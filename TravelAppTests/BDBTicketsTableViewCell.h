//
//  BDBTicketsTableViewCell.h
//  TravelAppTests
//
//  Created by Bruno Domínguez on 04/03/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDBTicketsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *vehicle;
@property (weak, nonatomic) IBOutlet UILabel *agency;
@property (weak, nonatomic) IBOutlet UILabel *frequency;
@property (weak, nonatomic) IBOutlet UILabel *timeTrip;
@property (weak, nonatomic) IBOutlet UILabel *sName;
@property (weak, nonatomic) IBOutlet UILabel *tName;
- (IBAction)ticket:(id)sender;

@end
