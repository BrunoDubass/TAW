//
//  BDBTransitItinerary.h
//  TravelAppTests
//
//  Created by Bruno Domínguez on 16/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDBTransitItinerary : NSObject

@property (strong, nonatomic)NSArray *legs;

-(id)initWithLegs:(NSArray*)aLegs;

@end
