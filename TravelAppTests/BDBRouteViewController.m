//
//  BDBRouteViewController.m
//  TravelAppTests
//
//  Created by Bruno Domínguez on 24/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBRouteViewController.h"
#import "BDBAllRoutes.h"
#import "BDBRouteCollectionViewCell.h"
#import "BDBIndicativePrice.h"
#import "BDBRoute.h"
#import "BDBFlightSegment.h"
#import "BDBStop.h"
#import "BDBRoute.h"
#import "BDBTransitSegment.h"
#import "BDBWalkCarSegment.h"
#import "BDBAnnotation.h"
#import "BDBSegmentViewController.h"
#import "BDBAirports.h"

@interface BDBRouteViewController ()

@property (strong, nonatomic)NSArray *path;

@property (copy, nonatomic  ) NSString       * latitudeA;
@property (copy, nonatomic  ) NSString       * longitudeA;
@property (copy, nonatomic  ) NSString       * latitudeB;
@property (copy, nonatomic  ) NSString       * longitudeB;

@property (nonatomic)NSUInteger segmentIndex;

@end

@implementation BDBRouteViewController


@synthesize coordinate;


static NSString * const reuseIdentifier = @"Cell";



#pragma mark - LIFECYCLE

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setMapRouteAtIndexPath:0];
    self.segmentIndex = 0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //[self applyMapViewMemoryFix];
}





#pragma mark - COLLECTION VIEW DATA SOURCE & DELEGATE

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.allRoutes.routes.count;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BDBRouteCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    self.path = [[self.allRoutes.routes objectAtIndex:indexPath.row]segments];
    [cell.cellMapView removeAnnotations:cell.cellMapView.annotations];
    [cell.cellMapView removeOverlays:cell.cellMapView.overlays];
    
    cell.routeLabel.text = [NSString stringWithFormat:@"%@ - %.2f km - %.2f min - %.2f eur",[[self.allRoutes.routes objectAtIndex:indexPath.row]name], [[self.allRoutes.routes objectAtIndex:indexPath.row]distanceR], [[self.allRoutes.routes objectAtIndex:indexPath.row]timeTrip], [[[self.allRoutes.routes objectAtIndex:indexPath.row]indicativePrice]price]];
    
    cell.cellMapView.zoomEnabled = YES;
    
    [cell.cellMapView addAnnotation:self.pointAnnotation1];
    [cell.cellMapView addAnnotation:self.pointAnnotation2];
    
    [self.path enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        if ([obj isKindOfClass:[BDBFlightSegment class]]) {
            
            BDBRoute *r = [self.allRoutes.routes objectAtIndex:indexPath.row];
            BDBStop *s1 = [r.stops objectAtIndex:[obj index]];
            BDBStop *s2 = [r.stops objectAtIndex:[obj index]+1];
            
            [self convertGPSStringToCLLocation2dA:s1.pos CLLocation2dB:s2.pos];
       
            
            CLLocationCoordinate2D loc1 = CLLocationCoordinate2DMake(self.latitudeA.doubleValue, self.longitudeA.doubleValue);
            CLLocationCoordinate2D loc2 = CLLocationCoordinate2DMake(self.latitudeB.doubleValue, self.longitudeB.doubleValue);
            
            
            CLLocationCoordinate2D locArray[2] = {loc1, loc2};
            
            MKPolyline *poli = [MKPolyline polylineWithCoordinates: locArray count:2];
            
            [cell.cellMapView addOverlay:poli];
            
        }else{
            
            BDBWalkCarSegment *segmentObject;
            if ([obj isKindOfClass:[BDBWalkCarSegment class]]) {
                segmentObject = obj;
            }else{
                segmentObject = obj;
            }
            
            [cell.cellMapView addOverlay:[self polylineWithEncodedString:segmentObject.path]];
            
            
        }
    }];
    

    
    
    
    MKMapRect zoomRect = MKMapRectNull;
    for (id <MKAnnotation> annotation in cell.cellMapView.annotations)
    {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
        zoomRect = MKMapRectUnion(zoomRect, pointRect);
    }
    [cell.cellMapView setVisibleMapRect:zoomRect edgePadding:UIEdgeInsetsMake(20, 20, 20, 20) animated:YES];
    
    
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self setMapRouteAtIndexPath:indexPath.row];
    self.segmentIndex = indexPath.row;
    
    
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    //set color with animation
    [UIView animateWithDuration:0.1
                          delay:0
                        options:(UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         [cell setBackgroundColor:[UIColor colorWithRed:182/255.0f green:220/255.0f blue:254/255.0f alpha:0.3]];
                     }
                     completion:nil];
    
    
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    //set color with animation
    [UIView animateWithDuration:0.1
                          delay:0
                        options:(UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         [cell setBackgroundColor:[UIColor clearColor]];
                     }
                     completion:nil ];
}





#pragma mark - CONVERSIONS

- (MKPolyline *)polylineWithEncodedString:(NSString *)encodedString {
    const char *bytes = [encodedString UTF8String];
    NSUInteger length = [encodedString lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    NSUInteger idx = 0;
    
    NSUInteger count = length / 4;
    CLLocationCoordinate2D *coords = calloc(count, sizeof(CLLocationCoordinate2D));
    NSUInteger coordIdx = 0;
    
    float latitude = 0;
    float longitude = 0;
    while (idx < length) {
        char byte = 0;
        int res = 0;
        char shift = 0;
        
        do {
            byte = bytes[idx++] - 63;
            res |= (byte & 0x1F) << shift;
            shift += 5;
        } while (byte >= 0x20);
        
        float deltaLat = ((res & 1) ? ~(res >> 1) : (res >> 1));
        latitude += deltaLat;
        
        shift = 0;
        res = 0;
        
        do {
            byte = bytes[idx++] - 0x3F;
            res |= (byte & 0x1F) << shift;
            shift += 5;
        } while (byte >= 0x20);
        
        float deltaLon = ((res & 1) ? ~(res >> 1) : (res >> 1));
        longitude += deltaLon;
        
        float finalLat = latitude * 1E-5;
        float finalLon = longitude * 1E-5;
        
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(finalLat, finalLon);
        coords[coordIdx++] = coord;
        
        if (coordIdx == count) {
            NSUInteger newCount = count + 10;
            coords = realloc(coords, newCount * sizeof(CLLocationCoordinate2D));
            count = newCount;
        }
    }
    
    MKPolyline *polyline = [MKPolyline polylineWithCoordinates:coords count:coordIdx];
    free(coords);
    
    return polyline;
}


-(void)convertGPSStringToCLLocation2dA:(NSString*)posA CLLocation2dB:(NSString*)posB{
    
    NSRange comaA = [posA rangeOfString:@","];
    int comaPosA = (int) comaA.location;
    
    self.latitudeA = [posA substringWithRange:NSMakeRange(0, comaPosA)];
    self.longitudeA = [posA substringWithRange:NSMakeRange(comaPosA+1, [posA length]-(comaPosA+1))];
    
    NSRange comaB = [posB rangeOfString:@","];
    int comaPosB = (int) comaB.location;
    
    self.latitudeB = [posB substringWithRange:NSMakeRange(0, comaPosB)];
    self.longitudeB = [posB substringWithRange:NSMakeRange(comaPosB+1, [posB length]-(comaPosB+1))];
    
}



#pragma mark - MAP DELEGATE

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay {
    static int contador = 0;
    contador++;
    MKPolylineRenderer *polyline = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    
    if (contador %2 == 0) {
        polyline.strokeColor = [UIColor redColor];
        polyline.lineWidth = 3.0;
    }else{
        polyline.strokeColor = [UIColor blueColor];
        polyline.lineWidth = 3.0;
    }
    return polyline;
}





#pragma mark - MAP ROUTE



-(void)setMapRouteAtIndexPath:(NSUInteger)index{
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView removeOverlays:self.mapView.overlays];
    
    BDBRoute *r = [self.allRoutes.routes objectAtIndex:index];
    

    self.mapView.zoomEnabled = YES;
    
    
    self.path = [[self.allRoutes.routes objectAtIndex:index]segments];
    
    NSMutableArray *stops = [[NSMutableArray alloc]init];
    
    [r.stops enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        [self convertGPSStringToCLLocation2dA:[obj pos] CLLocation2dB:nil];
        
        self.pointAnnotation = [[BDBAnnotation alloc]initWithName:[obj name] coordinate:CLLocationCoordinate2DMake(self.latitudeA.doubleValue, self.longitudeA.doubleValue)];
        [stops addObject:self.pointAnnotation];
        
    }];
    
    [self.mapView addAnnotations:stops];
    
    [self.path enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        if ([obj isKindOfClass:[BDBFlightSegment class]]) {
            
            
            
            BDBStop *s1 = [r.stops objectAtIndex:[obj index]];
            BDBStop *s2 = [r.stops objectAtIndex:[obj index]+1];
            
            [self convertGPSStringToCLLocation2dA:s1.pos CLLocation2dB:s2.pos];
            
            
            CLLocationCoordinate2D loc1 = CLLocationCoordinate2DMake(self.latitudeA.doubleValue, self.longitudeA.doubleValue);
            CLLocationCoordinate2D loc2 = CLLocationCoordinate2DMake(self.latitudeB.doubleValue, self.longitudeB.doubleValue);
            
            
            CLLocationCoordinate2D locArray[2] = {loc1, loc2};
            
            MKPolyline *poli = [MKPolyline polylineWithCoordinates: locArray count:2];
            
            [self.mapView addOverlay:poli];
            
        }else{
            
            BDBWalkCarSegment *segmentObject;
            
            if ([obj isKindOfClass:[BDBWalkCarSegment class]]) {
                segmentObject = obj;
            }else{
                segmentObject = obj;
            }
            
            [self.mapView addOverlay:[self polylineWithEncodedString:segmentObject.path]];
            
            
        }
    
    }];
    
    self.infoMapLabel.text = [NSString stringWithFormat:@"%@ - %.2f km - %.2f min - %.2f eur",r.name, r.distanceR, r.timeTrip, r.indicativePrice.price];
    
    
    MKMapRect zoomRect = MKMapRectNull;
    for (id <MKAnnotation> annotation in self.mapView.annotations)
    {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
        zoomRect = MKMapRectUnion(zoomRect, pointRect);
    }
    [self.mapView setVisibleMapRect:zoomRect edgePadding:UIEdgeInsetsMake(20, 20, 20, 20) animated:YES];
}


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    BDBSegmentViewController *sVC = [segue destinationViewController];
    sVC.path = [[self.allRoutes.routes objectAtIndex:self.segmentIndex]segments];
    sVC.allRoutes = self.allRoutes;
    sVC.segmentIndex = self.segmentIndex;
    sVC.agencies = self.agencies;
    sVC.airlines = self.airlines;
    sVC.airports = self.airports;
    sVC.aircrafts = self.aircrafts;
    
}



@end
