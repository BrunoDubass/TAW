//
//  BDBRoute.m
//  TravelAppTests
//
//  Created by Bruno Domínguez on 16/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBRoute.h"

@implementation BDBRoute

-(id)initWithName:(NSString*)aName
         distance:(float) aDistance
         duration:(float) aDuration
            stops:(NSArray*)aStops
         segments:(NSArray*)aSegments
  indicativePrice:(BDBIndicativePrice *)aIndicativePrice{
    
    if (self = [super init]) {
        
        _name = aName;
        _distance = aDistance;
        _duration = aDuration;
        _stops = aStops;
        _segments = aSegments;
        _indicativePrice = aIndicativePrice;
    }
    return self;
}



@end
