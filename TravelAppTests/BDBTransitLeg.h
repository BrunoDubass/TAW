//
//  BDBTransitLeg.h
//  TravelAppTests
//
//  Created by Bruno Domínguez on 16/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDBTransitLeg : NSObject

@property (strong, nonatomic)NSURL *url;
@property (strong, nonatomic)NSArray *transitHop;

-(id)initWithUrl:(NSURL*)aUrl
      transitHop:(NSArray*)aTransitHop;

@end
