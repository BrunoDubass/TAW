//
//  BDBTicketsTableViewController.h
//  TravelAppTests
//
//  Created by Bruno Domínguez on 04/03/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BDBRoute;


@interface BDBTicketsTableViewController : UITableViewController

@property (strong,nonatomic) BDBRoute *r;
@property (nonatomic)NSUInteger segmentIndex;

@property (strong, nonatomic)NSArray *agencies;
@property (strong, nonatomic)NSArray *airlines;
@property (strong, nonatomic)NSArray *airports;

@end
