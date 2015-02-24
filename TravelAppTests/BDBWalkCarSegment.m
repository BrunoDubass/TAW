//
//  BDBWalkCarSegment.m
//  TravelAppTests
//
//  Created by Bruno Domínguez on 16/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBWalkCarSegment.h"

@implementation BDBWalkCarSegment

-(id)initWithKind:(NSString*)aKind
          subKind:(NSString*)aSubKind
          vehicle:(NSString*)aVehicle
          isMajor:(BOOL)aIsMajor
       isImperial:(BOOL)aIsImperial
         distance:(float)aDistance
         timeTrip:(float)aDuration
            sName:(NSString*)aSName
             sPos:(NSString*)aSPos
            tName:(NSString*)aTName
             tPos:(NSString*)aTPos
  indicativePrice:(BDBIndicativePrice*)aIndicativePrice
             path:(NSString*)aPath{
    
    if (self = [super init]) {
        _kind = aKind;
        _subKind = aSubKind;
        _vehicle = aVehicle;
        _isMajor = aIsMajor;
        _isImperial = aIsImperial;
        _distanceR = aDistance;
        _timeTrip = aDuration;
        _sName = aSName;
        _sPos = aSPos;
        _tName = aTName;
        _tPos = aTPos;
        _indicativePrice = aIndicativePrice;
        _path = aPath;
    }
    return self;
}

@end
