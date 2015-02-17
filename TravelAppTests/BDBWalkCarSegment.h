//
//  BDBWalkCarSegment.h
//  TravelAppTests
//
//  Created by Bruno Domínguez on 16/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDBIndicativePrice.h"

@interface BDBWalkCarSegment : NSObject

@property (copy, nonatomic)NSString *kind;
@property (copy, nonatomic)NSString *subKind;
@property (copy, nonatomic)NSString *vehicle;
@property (nonatomic)BOOL isMajor;
@property (nonatomic)BOOL isImperial;
@property (nonatomic)float distance;
@property (nonatomic)float duration;
@property (copy, nonatomic)NSString *sName;
@property (copy, nonatomic)NSString *sPos;
@property (copy, nonatomic)NSString *tName;
@property (copy, nonatomic)NSString *tPos;
@property (strong, nonatomic)BDBIndicativePrice *indicativePrice;
@property (copy, nonatomic)NSString *path;

-(id)initWithKind:(NSString*)aKind
          subKind:(NSString*)aSubKind
          vehicle:(NSString*)aVehicle
          isMajor:(BOOL)aIsMajor
       isImperial:(BOOL)aIsImperial
         distance:(float)aDistance
         duration:(float)aDuration
            sName:(NSString*)aSName
             sPos:(NSString*)aSPos
            tName:(NSString*)aTName
             tPos:(NSString*)aTPos
  indicativePrice:(BDBIndicativePrice*)aIndicativePrice
             path:(NSString*)aPath;

@end
