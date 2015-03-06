//
//  BDBInfoViewController.m
//  TravelAppTests
//
//  Created by Bruno Domínguez on 24/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBInfoViewController.h"
#import "BDBAnnotation.h"


@interface BDBInfoViewController ()

@property (copy, nonatomic  ) NSString       * latitude;
@property (copy, nonatomic  ) NSString       * longitude;

@property (strong, nonatomic) id<MKAnnotation      > pointAnnotation;

@end

@implementation BDBInfoViewController



#pragma mark - LIFECYCLE

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    
    
    self.longNameLabel.text = self.longName;
    self.kindLabel.text = self.kind;
    self.posLabel.text = self.pos;
    self.countryCodeLabel.text = self.countryCode;
    self.regionCodeLabel.text = self.regionCode;
    self.timeZoneLabel.text = self.timeZone;
    
    [self convertGPSStringToCLLocation2d:self.pos];
    
    self.pointAnnotation = [[BDBAnnotation alloc]initWithName:self.longName
                                                    coordinate:CLLocationCoordinate2DMake([self.latitude floatValue], [self.longitude floatValue])];
    
    
    [self.infoMapView addAnnotation:self.pointAnnotation];
    [self.infoMapView setDelegate:self];
    
    //[self.infoMapView showAnnotations:@[self.pointAnnotation]animated:YES];
    
    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = [self.latitude doubleValue];
    region.center.longitude = [self.longitude doubleValue];
    region.span.longitudeDelta = 0.03f;
    region.span.latitudeDelta = 0.03f;
    [self.infoMapView setRegion:region animated:YES];
    
    self.infoMapView.zoomEnabled = YES;
    
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //[self applyMapViewMemoryFix];
}



#pragma mark - CONVERSIONS

//GPSSTRING TO CLLOCATION2D

-(void)convertGPSStringToCLLocation2d:(NSString*)pos{
    
    NSRange coma = [pos rangeOfString:@","];
    int comaPos = (int) coma.location;
    
    self.latitude = [pos substringWithRange:NSMakeRange(0, comaPos)];
    self.longitude = [pos substringWithRange:NSMakeRange(comaPos+1, [pos length]-(comaPos+1))];
}


#pragma mark - MAP DELEGATE

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay {
    static int contador = 0;
    contador++;
    MKPolylineRenderer *polyline = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    
    if (contador %2 == 0) {
        polyline.strokeColor = [UIColor redColor];
        polyline.lineWidth = 3.0;
    }else{
        polyline.strokeColor = [UIColor blueColor];
        polyline.lineWidth = 3.0;
    }
    return polyline;
}

- (void)applyMapViewMemoryFix{
    
    switch (self.infoMapView.mapType) {
        case MKMapTypeHybrid:
        {
            self.infoMapView.mapType = MKMapTypeStandard;
        }
            
            break;
        case MKMapTypeStandard:
        {
            self.infoMapView.mapType = MKMapTypeHybrid;
        }
            
            break;
        default:
            break;
    }
    self.infoMapView.showsUserLocation = NO;
    self.infoMapView.delegate = nil;
    [self.infoMapView removeFromSuperview];
    self.infoMapView = nil;
}


@end
