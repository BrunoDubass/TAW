//
//  BDBFlightCodeShare.h
//  TravelAppTests
//
//  Created by Bruno Domínguez on 16/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDBFlightCodeShare : NSObject

@property (copy, nonatomic)NSString *airline;
@property (copy, nonatomic)NSString *flight;

-(id)initWithAirline:(NSString*)aAirline
              flight:(NSString*)aFlight;

@end
