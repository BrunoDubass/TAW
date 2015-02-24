//
//  BDBInfoViewController.h
//  TravelAppTests
//
//  Created by Bruno Domínguez on 24/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

@import UIKit;
@import MapKit;


@interface BDBInfoViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *longNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *kindLabel;
@property (weak, nonatomic) IBOutlet UILabel *posLabel;
@property (weak, nonatomic) IBOutlet UILabel *regionCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeZoneLabel;

@property (copy, nonatomic)NSString *longName;
@property (copy, nonatomic)NSString *kind;
@property (copy, nonatomic)NSString *pos;
@property (copy, nonatomic)NSString *regionCode;
@property (copy, nonatomic)NSString *countryCode;
@property (copy, nonatomic)NSString *timeZone;



@property (weak, nonatomic) IBOutlet MKMapView *infoMapView;




@end
