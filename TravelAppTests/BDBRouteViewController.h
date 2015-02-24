//
//  BDBRouteViewController.h
//  TravelAppTests
//
//  Created by Bruno Domínguez on 24/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

@import UIKit;
@class BDBAllRoutes;

@interface BDBRouteViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic)BDBAllRoutes *allRoutes;

@end
