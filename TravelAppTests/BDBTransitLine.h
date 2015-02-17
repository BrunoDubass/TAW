//
//  BDBTransitLine.h
//  TravelAppTests
//
//  Created by Bruno Domínguez on 16/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDBTransitLine : NSObject

@property (copy, nonatomic)NSString *name;
@property (copy, nonatomic)NSString *vehicle;
@property (copy, nonatomic)NSString *code;
@property (copy, nonatomic)NSString *agency;
@property (nonatomic)float frecuency;
@property (nonatomic)float duration;
@property (nonatomic)float days;

-(id)initWithName:(NSString*)aName
          vehicle:(NSString*)aVehicle
             code:(NSString*)aCode
           agency:(NSString*)aAgency
        frecuency:(float)aFrecuency
         duration:(float)aDuration
             days:(float)aDays;

@end
