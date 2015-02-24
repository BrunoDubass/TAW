//
//  BDBRouteCollectionViewController.h
//  TravelAppTests
//
//  Created by Bruno Domínguez on 24/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

@import UIKit;
@class BDBAllRoutes;
@class BDBRouteCollectionViewCell;

@interface BDBRouteCollectionViewController : UICollectionViewController

@property (strong, nonatomic)BDBAllRoutes *allRoutes;

@end
