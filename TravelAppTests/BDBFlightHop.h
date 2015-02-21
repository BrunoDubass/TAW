//
//  BDBFlightHop.h
//  TravelAppTests
//
//  Created by Bruno Domínguez on 16/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDBFlightCodeShare.h"

@interface BDBFlightHop : NSObject

@property (copy, nonatomic)NSString *sCode;
@property (copy, nonatomic)NSString *tCode;
@property (copy, nonatomic)NSString *sTerminal;
@property (copy, nonatomic)NSString *tTerminal;
@property (nonatomic)float sTime;
@property (nonatomic)float tTime;
@property (copy, nonatomic)NSString *flight;
@property (copy, nonatomic)NSString *airline;
@property (nonatomic)float timeTrip;
@property (copy, nonatomic)NSString *aircraft;
@property (strong, nonatomic)NSArray *codeShare;
@property (nonatomic)NSUInteger dayChange;
@property (nonatomic)float iDuration;
@property (nonatomic)NSUInteger iDayChange;

-(id)initWithSCode:(NSString*)aSCode
             tCode:(NSString*)aTCode
         sTerminal:(NSString*)aSTerminal
         tTerminal:(NSString*)aTTerminal
             sTime:(float)aSTime
             tTime:(float)aTTime
            flight:(NSString*)aFlight
           airline:(NSString*)aAirline
          timeTrip:(float)aDuration
          aircraft:(NSString*)aAircraft
         codeShare:(NSArray*)aCodeShare
         dayChange:(NSUInteger)aDayChange
         iDuration:(float)aIduration
        iDayChange:(NSUInteger)aIDayChange;

@end
