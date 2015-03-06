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
@class BDBAllRoutes;


@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, MKMapViewDelegate, CLLocationManagerDelegate>



@property (strong, nonatomic)CLLocationManager* lManager;


@property (weak, nonatomic) IBOutlet UITextField *originSearch;
@property (weak, nonatomic) IBOutlet UITextField *destinationSearch;

@property (strong, nonatomic)BDBTravelModel* places;
@property (weak, nonatomic) IBOutlet UITableView *originTableView;
@property (weak, nonatomic) IBOutlet UITableView *destinationTableView;



@property (strong, nonatomic) BDBAllRoutes   *allRoutes;

- (MKPolyline *)polylineWithEncodedString:(NSString *)encodedString;


- (IBAction)search:(id)sender;
- (IBAction)originAutoComplete:(id)sender;
- (IBAction)destinationAutoComplete:(id)sender;
-(void)convertGPSStringToCLLocation2d:(NSString*)pos;
-(void)convertGPSStringToCLLocation2dA:(NSString*)posA CLLocation2dB:(NSString*)posB;
-(void)getDataFromJSON:(NSDictionary*)JSONDic;

@end

