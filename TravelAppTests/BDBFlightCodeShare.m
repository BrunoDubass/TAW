//
//  BDBFlightCodeShare.m
//  TravelAppTests
//
//  Created by Bruno Domínguez on 16/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBFlightCodeShare.h"

@implementation BDBFlightCodeShare

-(id)initWithAirline:(NSString*)aAirline
              flight:(NSString*)aFlight{
    
    if (self = [super init]) {
        _airline = aAirline;
        _flight = aFlight;
    }
    return self;
}

@end
