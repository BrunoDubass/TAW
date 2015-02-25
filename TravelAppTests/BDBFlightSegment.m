//
//  BDBFlightSegment.m
//  TravelAppTests
//
//  Created by Bruno Domínguez on 16/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBFlightSegment.h"

@implementation BDBFlightSegment

-(id)initWithKind:(NSString*)aKind
          isMajor:(BOOL)aIsMajor
         distance:(float)aDistance
         timeTrip:(float)aDuration
 transferDuration:(float)aTransferDuration
            sCode:(NSString*)aSCode
            tCode:(NSString*)aTCode
  indicativePrice:(BDBIndicativePrice*)aIndicativePrice
      itineraries:(NSArray*)aItineraries
            index:(NSUInteger)aIndex{
    
    if (self = [super init]) {
        _kind = aKind;
        _isMajor = aIsMajor;
        _distanceR = aDistance;
        _timeTrip = aDuration;
        _transferDuration = aTransferDuration;
        _sCode = aSCode;
        _tCode = aTCode;
        _indicativePrice = aIndicativePrice;
        _itineraries = aItineraries;
        _index = aIndex;
    }
    return self;
}

@end
