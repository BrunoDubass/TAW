//
//  BDBTransitTicketData.m
//  TravelAppTests
//
//  Created by Bruno Domínguez on 05/03/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBTransitTicketData.h"

@implementation BDBTransitTicketData

-(id)initWithSName:(NSString*)aSName
             tName:(NSString*)aTName
           vehicle:(NSString*)aVehicle
            agency:(NSString*)aAgency
         frequency:(NSInteger)aFrequency
          timeTrip:(float)aTimeTrip
               url:(NSURL*)aUrl
        displayUrl:(NSString*)aDisplayUrl{
    
    if (self = [super init]) {
        _sName = aSName;
        _tName = aTName;
        _vehicle = aVehicle;
        _agency = aAgency;
        _frequency = aFrequency;
        _timeTrip = aTimeTrip;
        _url = aUrl;
        _displayUrl = aDisplayUrl;
    }
    return self;
}

@end
