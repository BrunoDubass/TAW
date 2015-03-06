//
//  BDBFlightHop.m
//  TravelAppTests
//
//  Created by Bruno Domínguez on 16/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBFlightHop.h"

@implementation BDBFlightHop

-(id)initWithSCode:(NSString*)aSCode
             tCode:(NSString*)aTCode
         sTerminal:(NSString*)aSTerminal
         tTerminal:(NSString*)aTTerminal
             sTime:(NSString*)aSTime
             tTime:(NSString*)aTTime
            flight:(NSString*)aFlight
           airline:(NSString*)aAirline
          timeTrip:(float)aDuration
          aircraft:(NSString*)aAircraft
         codeShare:(NSArray*)aCodeShare
         dayChange:(NSUInteger)aDayChange
         iDuration:(float)aIduration
        iDayChange:(NSUInteger)aIDayChange{
    
    if (self = [super init]) {
        _sCode = aSCode;
        _tCode = aTCode;
        _sTerminal = aSTerminal;
        _tTerminal = aTTerminal;
        _sTime = aSTime;
        _tTime = aTTime;
        _flight = aFlight;
        _airline = aAirline;
        _timeTrip = aDuration;
        _aircraft = aAircraft;
        _codeShare = aCodeShare;
        _dayChange = aDayChange;
        _iDuration = aIduration;
        _iDayChange = aIDayChange;
    }
    return self;
}

@end
