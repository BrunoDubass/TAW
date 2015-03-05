//
//  BDBSegmentViewController.m
//  TravelAppTests
//
//  Created by Bruno Domínguez on 26/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBSegmentViewController.h"
#import "BDBAllRoutes.h"
#import "BDBIndicativePrice.h"
#import "BDBRoute.h"
#import "BDBFlightSegment.h"
#import "BDBStop.h"
#import "BDBTransitSegment.h"
#import "BDBWalkCarSegment.h"
#import "BDBAnnotation.h"
#import "BDBSegmentCollectionViewCell.h"
#import "BDBStopsTableViewController.h"
#import "BDBTicketsTableViewController.h"
#import "BDBAirports.h"
#import "BDBFlightsTableViewController.h"

@interface BDBSegmentViewController ()

@property (strong, nonatomic)NSArray *segmentArray;

@property (nonatomic)NSUInteger stopsIndex; //1 segment from segment's array

@property (copy, nonatomic  ) NSString       * latitudeA;
@property (copy, nonatomic  ) NSString       * longitudeA;
@property (copy, nonatomic  ) NSString       * latitudeB;
@property (copy, nonatomic  ) NSString       * longitudeB;
@property (strong, nonatomic) BDBRoute *r;

@end

@implementation BDBSegmentViewController


@synthesize coordinate;


static NSString * const reuseIdentifier2 = @"segmentCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.r = [self.allRoutes.routes objectAtIndex:self.segmentIndex];
    self.routeInfo.text = [NSString stringWithFormat:@"%@  -  %@ - %@     -     %.2f    -    %.2f", self.r.name, [[self.r.stops objectAtIndex:0]name], [[self.r.stops objectAtIndex:self.r.stops.count-1]name], self.r.distanceR, self.r.indicativePrice.price];
    
    [self setMapSegmentAtIndexPath:0];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma mark - COLLECTION VIEW DATA SOURCE

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.path.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    BDBSegmentCollectionViewCell *segCell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier2 forIndexPath:indexPath];
    
    segCell.numberOfSegment.text = [NSString stringWithFormat:@"%u", indexPath.row+1];
    segCell.segmentFromTo.text = [NSString stringWithFormat:@"%@", [[self.r.stops objectAtIndex:indexPath.row]name] ];
    
    segCell.segmentFromTo2.text = [NSString stringWithFormat:@"%@", [[self.r.stops objectAtIndex:indexPath.row+1]name]];
    
    segCell.kindOfSegment.text = [NSString stringWithFormat:@"%@", [[self.path objectAtIndex:indexPath.row]kind]];
    segCell.distanceOfSegment.text = [NSString stringWithFormat:@"%.2f km", [[self.path objectAtIndex:indexPath.row]distanceR]];
    
    segCell.priceOfSegment.text = [NSString stringWithFormat:@"%.2f €", [[[self.path objectAtIndex:indexPath.row]indicativePrice]price]];
    segCell.timeTripLabel.text = [NSString stringWithFormat:@"%.2f h", [[self.path objectAtIndex:indexPath.row]timeTrip]/60];
    
    return segCell;
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

#pragma mark - COLLECTION VIEW DELEGATE

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self setMapSegmentAtIndexPath:indexPath.row];
    self.stopsIndex = indexPath.row;
    
    
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

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    
    
    
}

-(void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
//    //set color with animation
//    [UIView animateWithDuration:0.1
//                          delay:0
//                        options:(UIViewAnimationOptionAllowUserInteraction)
//                     animations:^{
//                         [cell setBackgroundColor:[UIColor colorWithRed:232/255.0f green:232/255.0f blue:232/255.0f alpha:0.5]];
//                     }
//                     completion:nil];
}

//-(void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
//    //set color with animation
//    [UIView animateWithDuration:0.1
//                          delay:0
//                        options:(UIViewAnimationOptionAllowUserInteraction)
//                     animations:^{
//                         [cell setBackgroundColor:[UIColor clearColor]];
//                     }
//                     completion:nil ];
//}


-(void)setMapSegmentAtIndexPath:(NSUInteger)index{
    
    [self.mapViewSegment removeAnnotations:self.mapViewSegment.annotations];
    [self.mapViewSegment removeOverlays:self.mapViewSegment.overlays];
    
    self.r = [self.allRoutes.routes objectAtIndex:self.segmentIndex];
    
    
    self.mapViewSegment.zoomEnabled = YES;
    
    if ([[self.r.segments objectAtIndex:index]isKindOfClass:[BDBWalkCarSegment class]]) {
        
        [self convertGPSStringToCLLocation2dA:[[self.r.stops objectAtIndex:index]pos] CLLocation2dB:[[self.r.stops objectAtIndex:index+1]pos]];
        
        self.pointAnnotation1 = [[BDBAnnotation alloc]initWithName:[[self.r.stops objectAtIndex:index]name] coordinate:CLLocationCoordinate2DMake(self.latitudeA.doubleValue, self.longitudeA.doubleValue)];
        
        self.pointAnnotation2 = [[BDBAnnotation alloc]initWithName:[[self.r.stops objectAtIndex:index+1]name] coordinate:CLLocationCoordinate2DMake(self.latitudeB.doubleValue, self.longitudeB.doubleValue)];
        
        
        
        
        [self.mapViewSegment addAnnotation:self.pointAnnotation1];
        [self.mapViewSegment addAnnotation:self.pointAnnotation2];
    }
    
         
    
    NSMutableArray *stops = [[NSMutableArray alloc]init];
    
    if ([[self.r.segments objectAtIndex:index]isKindOfClass:[BDBTransitSegment class]]) {
        [[[self.r.segments objectAtIndex:index]stops]enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [self convertGPSStringToCLLocation2dA:[obj pos] CLLocation2dB:nil];
            self.pointAnnotation = [[BDBAnnotation alloc]initWithName:[obj name]coordinate:CLLocationCoordinate2DMake(self.latitudeA.doubleValue, self.longitudeA.doubleValue)];
            [stops addObject:self.pointAnnotation];
        }];
        
        [self.mapViewSegment addAnnotations:stops];
    }
    
    
    
        
        if ([[self.r.segments objectAtIndex:index] isKindOfClass:[BDBFlightSegment class]]) {
            
            
            
            BDBStop *s1 = [self.r.stops objectAtIndex:index];
            BDBStop *s2 = [self.r.stops objectAtIndex:index+1];
            
            [self convertGPSStringToCLLocation2dA:s1.pos CLLocation2dB:s2.pos];
            
            
            CLLocationCoordinate2D loc1 = CLLocationCoordinate2DMake(self.latitudeA.doubleValue, self.longitudeA.doubleValue);
            CLLocationCoordinate2D loc2 = CLLocationCoordinate2DMake(self.latitudeB.doubleValue, self.longitudeB.doubleValue);
            
            
            
            CLLocationCoordinate2D locArray[2] = {loc1, loc2};
            
            MKPolyline *poli = [MKPolyline polylineWithCoordinates: locArray count:2];
            
            self.pointAnnotation1 = [[BDBAnnotation alloc]initWithName:[[self.r.stops objectAtIndex:index]name] coordinate:CLLocationCoordinate2DMake(self.latitudeA.doubleValue, self.longitudeA.doubleValue)];
            
            self.pointAnnotation2 = [[BDBAnnotation alloc]initWithName:[[self.r.stops objectAtIndex:index+1]name] coordinate:CLLocationCoordinate2DMake(self.latitudeB.doubleValue, self.longitudeB.doubleValue)];
            
            
            
            
            [self.mapViewSegment addAnnotation:self.pointAnnotation1];
            [self.mapViewSegment addAnnotation:self.pointAnnotation2];
            
            [self.mapViewSegment addOverlay:poli];
            
        }else{
            
            BDBWalkCarSegment *segmentObject;
            
            if ([[self.r.segments objectAtIndex:index ] isKindOfClass:[BDBWalkCarSegment class]]) {
                segmentObject = [self.r.segments objectAtIndex:index ];
            }else{
                segmentObject = [self.r.segments objectAtIndex:index ];
            }
            
            [self.mapViewSegment addOverlay:[self polylineWithEncodedString:segmentObject.path]];
            
            
        }
        
    
    
//    self.infoMapLabel.text = [NSString stringWithFormat:@"%@ - %.2f km - %.2f min - %.2f eur",r.name, r.distanceR, r.timeTrip, r.indicativePrice.price];
    
    
    MKMapRect zoomRect = MKMapRectNull;
    for (id <MKAnnotation> annotation in self.mapViewSegment.annotations)
    {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
        zoomRect = MKMapRectUnion(zoomRect, pointRect);
    }
    [self.mapViewSegment setVisibleMapRect:zoomRect edgePadding:UIEdgeInsetsMake(20, 20, 20, 20) animated:YES];
}





 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     
     if ([segue.identifier isEqualToString:@"segueStops"]) {
         BDBStopsTableViewController *tVC = [segue destinationViewController];
         tVC.stopsIndex = self.stopsIndex;
         tVC.r = self.r;
     }
     if ([segue.identifier isEqualToString:@"tickets"]) {
         BDBTicketsTableViewController *tiVC = [segue destinationViewController];
         tiVC.r = self.r;
         tiVC.segmentIndex = self.stopsIndex;
         tiVC.agencies = self.agencies;
         tiVC.airlines = self.airlines;
         tiVC.airports = self.airports;
     }
     if ([segue.identifier isEqualToString:@"flightSegue"]) {
         BDBFlightsTableViewController *fVC = [segue destinationViewController];
         fVC.r = self.r;
         fVC.segmentIndex = self.stopsIndex;
         fVC.agencies = self.agencies;
         fVC.airlines = self.airlines;
         fVC.airports = self.airports;
         fVC.aircrafts = self.aircrafts;
         
     }
 }

#pragma mark - TABLEVIEW DELEGATE & DATA SOURCE

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellId = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}


@end