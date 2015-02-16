//
//  BDBAnnotation.h
//  TravelAppTests
//
//  Created by Bruno Domínguez on 05/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

@import Foundation;
@import CoreLocation;
@import MapKit;

@interface BDBAnnotation : NSObject <MKAnnotation>

-(id)initWithName:(NSString*)longName coordinate:(CLLocationCoordinate2D)coord;

@end
