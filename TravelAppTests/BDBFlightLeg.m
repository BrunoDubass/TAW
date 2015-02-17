//
//  BDBFlightLeg.m
//  TravelAppTests
//
//  Created by Bruno Domínguez on 16/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBFlightLeg.h"

@implementation BDBFlightLeg

-(id)initWithDays:(float)aDays
             hops:(NSArray*)aHops
 indicativePrices:(BDBIndicativePrice*)aIndicativeprice{
    
    if (self = [super init]) {
        _days = aDays;
        _hops = aHops;
        _indicativePrice = aIndicativeprice;
    }
    return self;
}

@end
