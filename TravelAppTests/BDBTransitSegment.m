//
//  BDBTransitSegment.m
//  TravelAppTests
//
//  Created by Bruno Domínguez on 16/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBTransitSegment.h"

@implementation BDBTransitSegment

-(id)initWithKind:(NSString*)aKind
          subKind:(NSString*)aSubKind
          isMajor:(BOOL)aIsMajor
       isImperial:(BOOL)aIsImperial
         distance:(float)aDistance
         timeTrip:(float)aDuration
 transferDuration:(float)aTransferDuration
            sName:(NSString*)aSName
             sPos:(NSString*)aSPos
            tName:(NSString*)aTName
             tPos:(NSString*)aTPos
  indicativePrice:(BDBIndicativePrice*)aIndicativePrice
      itineraries:(NSArray*)aItineraries
             path:(NSString*)aPath
            stops:(NSArray*)aStops{
    
    if (self = [super init]) {
        _kind = aKind;
        _subKind = aSubKind;
        _isMajor = aIsMajor;
        _isImperial = aIsImperial;
        _distanceR = aDistance;
        _timeTrip = aDuration;
        _transferDuration = aTransferDuration;
        _sName = aSName;
        _sPos = aSPos;
        _tName = aTName;
        _tPos = aTPos;
        _indicativePrice = aIndicativePrice;
        _itineraries = aItineraries;
        _path = aPath;
        _stops = aStops;
        
    }
    return self;
}

@end
