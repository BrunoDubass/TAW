//
//  BDBFlightLeg.h
//  TravelAppTests
//
//  Created by Bruno Domínguez on 16/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDBIndicativePrice.h"

@interface BDBFlightLeg : NSObject

@property (nonatomic)float days;
@property (strong, nonatomic)NSArray *hops;
@property (strong, nonatomic)BDBIndicativePrice *indicativePrice;

-(id)initWithDays:(float)aDays
             hops:(NSArray*)aHops
 indicativePrices:(BDBIndicativePrice*)aIndicativeprice;

@end
