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

@interface BDBRouteViewController ()

@property (strong, nonatomic)NSArray *path;

@end

@implementation BDBRouteViewController


@synthesize coordinate;


static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setMapRouteAtIndexPath:0];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - COLLECTION VIEW DATA SOURCE

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.allRoutes.routes.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BDBRouteCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    self.path = [self.routesArray objectAtIndex:indexPath.row];
    [cell.cellMapView removeAnnotations:cell.cellMapView.annotations];
    [cell.cellMapView removeOverlays:cell.cellMapView.overlays];
    
    cell.routeLabel.text = [NSString stringWithFormat:@"%@ - %.2f km - %.2f min - %.2f eur",[[self.allRoutes.routes objectAtIndex:indexPath.row]name], [[self.allRoutes.routes objectAtIndex:indexPath.row]distanceR], [[self.allRoutes.routes objectAtIndex:indexPath.row]timeTrip], [[[self.allRoutes.routes objectAtIndex:indexPath.row]indicativePrice]price]];
    
    cell.cellMapView.zoomEnabled = YES;
    
    [cell.cellMapView addAnnotation:self.pointAnnotation1];
    [cell.cellMapView addAnnotation:self.pointAnnotation2];
    
    for (MKPolyline *obj in self.path) {
        [cell.cellMapView addOverlay:obj];
    }

    
    //[cell.cellMapView showAnnotations:@[self.pointAnnotation1, self.pointAnnotation2] animated:YES];
    
    
    
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
    
    [self setMapRouteAtIndexPath:indexPath.row];
    
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    
    
    
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


-(void)setMapRouteAtIndexPath:(NSUInteger)index{
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView removeOverlays:self.mapView.overlays];
    
    self.mapView.zoomEnabled = YES;
    
    [self.mapView addAnnotation:self.pointAnnotation1];
    [self.mapView addAnnotation:self.pointAnnotation2];
    
    self.path = [self.routesArray objectAtIndex:index];
    
    for (MKPolyline *obj in self.path) {
        [self.mapView addOverlay:obj];
    }
    
    
    MKMapRect zoomRect = MKMapRectNull;
    for (id <MKAnnotation> annotation in self.mapView.annotations)
    {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
        zoomRect = MKMapRectUnion(zoomRect, pointRect);
    }
    [self.mapView setVisibleMapRect:zoomRect edgePadding:UIEdgeInsetsMake(20, 20, 20, 20) animated:YES];
}

@end
