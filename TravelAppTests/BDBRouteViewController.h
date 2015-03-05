//
//  BDBRouteViewController.h
//  TravelAppTests
//
//  Created by Bruno Domínguez on 24/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

@import UIKit;
@class BDBAllRoutes;
@import MapKit;

@interface BDBRouteViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, MKMapViewDelegate, MKAnnotation>

@property (strong, nonatomic)BDBAllRoutes *allRoutes;
@property (strong, nonatomic)NSArray *routesArray;
@property (strong, nonatomic) id<MKAnnotation      > pointAnnotation;
@property (strong, nonatomic) id<MKAnnotation      > pointAnnotation1;
@property (strong, nonatomic) id<MKAnnotation      > pointAnnotation2;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *infoMapLabel;

@property (strong, nonatomic)NSArray *agencies;
@property (strong, nonatomic)NSArray *airlines;
@property (strong, nonatomic)NSArray *airports;
@property (strong, nonatomic) NSArray *aircrafts;

-(void)setMapRouteAtIndexPath:(NSUInteger)index;

@end
