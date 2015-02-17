//
//  BDBFlightItinerary.m
//  TravelAppTests
//
//  Created by Bruno Domínguez on 16/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBFlightItinerary.h"

@implementation BDBFlightItinerary

-(id)initWithLegs:(NSArray*)aLegs
         isHidden:(BOOL)aIsHidden
         isReturn:(BOOL)aIsReturn{
    
    if (self = [super init]) {
        _legs = aLegs;
        _isHidden = aIsHidden;
        _isReturn = aIsReturn;
    }
    return self;
}

@end
