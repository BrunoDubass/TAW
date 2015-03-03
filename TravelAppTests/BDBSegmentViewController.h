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

@property (nonatomic)NSUInteger segmentIndex;

-(void)setMapRouteAtIndexPath:(NSUInteger)index;

@end
