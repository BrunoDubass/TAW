//
//  ViewController.h
//  TravelAppTests
//
//  Created by Bruno Domínguez on 26/01/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

@import UIKit;
@class BDBTravelModel;
@import MapKit;
@import CoreLocation;
@class BDBAnnotation;

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapViewOrigin;

@property (strong, nonatomic)CLLocationManager* lManager;


@property (weak, nonatomic) IBOutlet UITextField *originSearch;
@property (weak, nonatomic) IBOutlet UITextField *destinationSearch;
@property (weak, nonatomic) IBOutlet UILabel *originKind;
@property (weak, nonatomic) IBOutlet UILabel *originName;
@property (weak, nonatomic) IBOutlet UILabel *originLongName;
@property (weak, nonatomic) IBOutlet UILabel *originPosition;
@property (weak, nonatomic) IBOutlet UILabel *originCountryCode;
@property (weak, nonatomic) IBOutlet UILabel *originRegionCode;
@property (weak, nonatomic) IBOutlet UILabel *originTimeZone;
@property (weak, nonatomic) IBOutlet UILabel *destinationKind;
@property (weak, nonatomic) IBOutlet UILabel *destinationName;
@property (weak, nonatomic) IBOutlet UILabel *destinationLongName;
@property (weak, nonatomic) IBOutlet UILabel *destinationPosition;
@property (weak, nonatomic) IBOutlet UILabel *destinationCountryCode;
@property (weak, nonatomic) IBOutlet UILabel *destinationRegionCode;
@property (weak, nonatomic) IBOutlet UILabel *destinationTimeZone;
@property (strong, nonatomic)BDBTravelModel* places;
@property (weak, nonatomic) IBOutlet UITableView *originTableView;
@property (weak, nonatomic) IBOutlet UITableView *destinationTableView;


- (MKPolyline *)polylineWithEncodedString:(NSString *)encodedString;


- (IBAction)search:(id)sender;
- (IBAction)originAutoComplete:(id)sender;
- (IBAction)destinationAutoComplete:(id)sender;
-(void)convertGPSStringToCLLocation2d:(NSString*)pos;

-(void)getDataFromJSON:(NSDictionary*)JSONDic;

@end

