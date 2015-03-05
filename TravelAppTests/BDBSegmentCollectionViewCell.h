//
//  BDBSegmentCollectionViewCell.h
//  TravelAppTests
//
//  Created by Bruno Domínguez on 26/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;

@interface BDBSegmentCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *numberOfSegment;
@property (weak, nonatomic) IBOutlet UILabel *kindOfSegment;
@property (weak, nonatomic) IBOutlet UILabel *distanceOfSegment;
@property (weak, nonatomic) IBOutlet UILabel *segmentFromTo;
@property (weak, nonatomic) IBOutlet UILabel *priceOfSegment;
@property (weak, nonatomic) IBOutlet UILabel *segmentFromTo2;
@property (weak, nonatomic) IBOutlet UILabel *timeTripLabel;


@end
