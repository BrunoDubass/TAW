//
//  BDBFlightsTableViewCell.h
//  TravelAppTests
//
//  Created by Bruno Domínguez on 05/03/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDBFlightsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *sCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *sTerminalLabel;
@property (weak, nonatomic) IBOutlet UILabel *sTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tTerminalLabel;
@property (weak, nonatomic) IBOutlet UILabel *tTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeTripLabel;
@property (weak, nonatomic) IBOutlet UILabel *flightLabel;
@property (weak, nonatomic) IBOutlet UILabel *airlineLabel;
@property (weak, nonatomic) IBOutlet UILabel *aircraftLabel;

@end
