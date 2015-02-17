//
//  BDBTransitHop.m
//  TravelAppTests
//
//  Created by Bruno Domínguez on 16/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBTransitHop.h"

@implementation BDBTransitHop

-(id)initWithSName:(NSString*)aSName
              sPos:(NSString*)aSPos
             tName:(NSString*)aTName
              tPos:(NSString*)aTPos
         frecuency:(float)aFrecuency
          duration:(float)aDuration
   indicativePrice:(BDBIndicativePrice*)aIndicativePrice
             lines:(NSArray*)aLines
          agencies:(NSArray*)aAgencies{
    
    if (self = [super init]) {
        _sName = aSName;
        _sPos = aSPos;
        _tName = aTName;
        _tPos = aTPos;
        _frecuency = aFrecuency;
        _duration = aDuration;
        _indicativePrice = aIndicativePrice;
        _lines = aLines;
        _agencies = aAgencies;
    }
    return self;
}

@end
