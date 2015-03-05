//
//  BDBSegmentViewController.h
//  TravelAppTests
//
//  Created by Bruno Domínguez on 26/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

@import UIKit;
@class BDBAllRoutes;
@import MapKit;

@interface BDBSegmentViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, MKMapViewDelegate, MKAnnotation>

@property (weak, nonatomic) IBOutlet UILabel *routeInfo;

@property (weak, nonatomic) IBOutlet MKMapView *mapViewSegment;

@property (strong, nonatomic)BDBAllRoutes *allRoutes;
@property (strong, nonatomic)NSArray *routesArray;
@property (strong, nonatomic) id<MKAnnotation      > pointAnnotation;
@property (strong, nonatomic) id<MKAnnotation      > pointAnnotation1;
@property (strong, nonatomic) id<MKAnnotation      > pointAnnotation2;
@property (strong, nonatomic)NSArray *path;

@property (strong, nonatomic)NSArray *agencies;
@property (strong, nonatomic)NSArray *airlines;
@property (strong, nonatomic)NSArray *airports;
@property (strong, nonatomic) NSArray *aircrafts;

@property (nonatomic)NSUInteger segmentIndex; //1 route from route's array

-(void)setMapSegmentAtIndexPath:(NSUInteger)index;

@end
