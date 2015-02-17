//
//  BDBTransitSegment.h
//  TravelAppTests
//
//  Created by Bruno Domínguez on 16/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDBIndicativePrice.h"
#import "BDBTransitItinerary.h"

@interface BDBTransitSegment : NSObject

@property (copy, nonatomic)NSString *kind;
@property (copy, nonatomic)NSString *subKind;
@property (nonatomic)BOOL isMajor;
@property (nonatomic)BOOL isImperial;
@property (nonatomic)float distance;
@property (nonatomic)float duration;
@property (nonatomic)float transferDuration;
@property (copy, nonatomic)NSString *sName;
@property (copy, nonatomic)NSString *sPos;
@property (copy, nonatomic)NSString *tName;
@property (copy, nonatomic)NSString *tPos;
@property (strong, nonatomic)BDBIndicativePrice *indicativePrice;
@property (strong, nonatomic)NSArray *itineraries;
@property (copy, nonatomic)NSString *path;
@property (strong, nonatomic)NSArray *stops;

-(id)initWithKind:(NSString*)aKind
          subKind:(NSString*)aSubKind
          isMajor:(BOOL)aIsMajor
       isImperial:(BOOL)aIsImperial
         distance:(float)aDistance
         duration:(float)aDuration
 transferDuration:(float)aTransferDuration
            sName:(NSString*)aSName
             sPos:(NSString*)aSPos
            tName:(NSString*)aTName
             tPos:(NSString*)aTPos
  indicativePrice:(BDBIndicativePrice*)aIndicativePrice
      itineraries:(NSArray*)aItineraries
             path:(NSString*)aPath
            stops:(NSArray*)aStops;

@end
