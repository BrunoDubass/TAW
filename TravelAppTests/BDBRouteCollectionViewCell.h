//
//  BDBRouteCollectionViewCell.h
//  TravelAppTests
//
//  Created by Bruno Domínguez on 24/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

@import UIKit;
@import MapKit;

@interface BDBRouteCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet MKMapView *cellMapView;
@property (weak, nonatomic) IBOutlet UILabel *routeLabel;

@end
