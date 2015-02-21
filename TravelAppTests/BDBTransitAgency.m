//
//  BDBTransitAgency.m
//  TravelAppTests
//
//  Created by Bruno Domínguez on 16/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBTransitAgency.h"

@implementation BDBTransitAgency

-(id)initWithAgency:(NSString*)aAgency
          frecuency:(NSUInteger)aFrecuency
           timeTrip:(NSUInteger)aDuration
            actions:(NSArray*)aActions{
    
    if (self = [super init]) {
        
        _agency = aAgency;
        _frecuency = aFrecuency;
        _timeTrip = aDuration;
        _actions = aActions;
    }
    return self;
}

@end
