//
//  BDBTransitLeg.m
//  TravelAppTests
//
//  Created by Bruno Domínguez on 16/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBTransitLeg.h"

@implementation BDBTransitLeg

-(id)initWithUrl:(NSURL*)aUrl transitHop:(NSArray*)aTransitHop{
    
    if (self = [super init]) {
        _url = aUrl;
        _transitHop = aTransitHop;
    }    
    return self;
}

@end
