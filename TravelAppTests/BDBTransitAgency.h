//
//  BDBTransitAgency.h
//  TravelAppTests
//
//  Created by Bruno Domínguez on 16/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDBTransitAgency : NSObject

@property (copy, nonatomic)NSString *agency;
@property (nonatomic)NSUInteger frecuency;
@property (nonatomic)NSUInteger timeTrip;
@property (strong, nonatomic)NSArray *actions;

-(id)initWithAgency:(NSString*)aAgency
          frecuency:(NSUInteger)aFrecuency
           timeTrip:(NSUInteger)aDuration
            actions:(NSArray*)aActions;

@end
