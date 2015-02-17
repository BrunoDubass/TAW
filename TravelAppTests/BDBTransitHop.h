//
//  BDBTransitHop.h
//  TravelAppTests
//
//  Created by Bruno Domínguez on 16/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDBIndicativePrice.h"

@interface BDBTransitHop : NSObject

@property (copy, nonatomic)NSString *sName;
@property (copy, nonatomic)NSString *sPos;
@property (copy, nonatomic)NSString *tName;
@property (copy, nonatomic)NSString *tPos;
@property (nonatomic)float frecuency;
@property (nonatomic)float duration;
@property (strong, nonatomic)BDBIndicativePrice *indicativePrice;
@property (strong, nonatomic)NSArray *lines;
@property (strong, nonatomic)NSArray *agencies;

-(id)initWithSName:(NSString*)aSName
              sPos:(NSString*)aSPos
             tName:(NSString*)aTName
              tPos:(NSString*)aTPos
         frecuency:(float)aFrecuency
          duration:(float)aDuration
   indicativePrice:(BDBIndicativePrice*)aIndicativePrice
             lines:(NSArray*)aLines
          agencies:(NSArray*)aAgencies;

@end
