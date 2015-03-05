//
//  BDBStopsTableViewController.h
//  TravelAppTests
//
//  Created by Bruno Domínguez on 03/03/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BDBRoute;

@interface BDBStopsTableViewController : UITableViewController

@property (nonatomic)NSUInteger stopsIndex;
@property (strong, nonatomic)BDBRoute *r;

@property (strong, nonatomic)NSArray *airports;

@end
