//
//  BDBTransitItinerary.m
//  TravelAppTests
//
//  Created by Bruno Domínguez on 16/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBTransitItinerary.h"

@implementation BDBTransitItinerary

-(id)initWithLegs:(NSArray*)aLegs{
    
    if (self = [super init]) {
        _legs = aLegs;
    }
    return self;
}

@end
