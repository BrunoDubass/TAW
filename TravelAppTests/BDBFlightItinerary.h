//
//  BDBFlightItinerary.h
//  TravelAppTests
//
//  Created by Bruno Domínguez on 16/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDBFlightItinerary : NSObject

@property (strong, nonatomic)NSArray *legs;
@property (nonatomic)BOOL isHidden;
@property (nonatomic)BOOL isReturn;

-(id)initWithLegs:(NSArray*)aLegs
         isHidden:(BOOL)aIsHidden
         isReturn:(BOOL)aIsReturn;

@end
