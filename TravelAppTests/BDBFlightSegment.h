//
//  BDBFlightSegment.h
//  TravelAppTests
//
//  Created by Bruno Domínguez on 16/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDBIndicativePrice.h"

@interface BDBFlightSegment : NSObject

@property (copy, nonatomic)NSString *kind;
@property (nonatomic)BOOL isMajor;
@property (nonatomic)float distance;
@property (nonatomic)float duration;
@property (nonatomic)float transferDuration;
@property (copy, nonatomic)NSString *sCode;
@property (copy, nonatomic)NSString *tCode;
@property (strong, nonatomic)BDBIndicativePrice *indicativePrice;
@property (strong, nonatomic)NSArray *itineraries;

-(id)initWithKind:(NSString*)aKind
          isMajor:(BOOL)aIsMajor
         distance:(float)aDistance
         duration:(float)aDuration
 transferDuration:(float)aTransferDuration
            sCode:(NSString*)aSCode
            tCode:(NSString*)aTCode
  indicativePrice:(BDBIndicativePrice*)aIndicativePrice
      itineraries:(NSArray*)aItineraries;

@end
