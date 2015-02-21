//
//  BDBTransitLine.m
//  TravelAppTests
//
//  Created by Bruno Domínguez on 16/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBTransitLine.h"

@implementation BDBTransitLine

-(id)initWithName:(NSString*)aName
          vehicle:(NSString*)aVehicle
             code:(NSString*)aCode
           agency:(NSString*)aAgency
        frecuency:(float)aFrecuency
         timeTrip:(float)aDuration
             days:(float)aDays{
    
    if (self = [super init]) {
        _name = aName;
        _vehicle = aVehicle;
        _code = aCode;
        _agency = aAgency;
        _frecuency = aFrecuency;
        _timeTrip = aDuration;
        _days = aDays;
    }
    return self;
}

@end
