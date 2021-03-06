//
//  BDBRoute.h
//  TravelAppTests
//
//  Created by Bruno Domínguez on 16/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDBIndicativePrice.h"

@interface BDBRoute : NSObject

@property (copy, nonatomic)NSString *name;
@property (nonatomic)float distanceR;
@property (nonatomic)float timeTrip;
@property (strong, nonatomic)NSArray *stops;
@property (strong, nonatomic)NSArray *segments;
@property (strong, nonatomic)BDBIndicativePrice *indicativePrice;

-(id)initWithName:(NSString*)aName
         distance:(float) aDistance
         timeTrip:(float) aDuration
            stops:(NSArray*)aStops
         segments:(NSArray*)aSegments
  indicativePrice:(BDBIndicativePrice*)aIndicativePrice;

@end
