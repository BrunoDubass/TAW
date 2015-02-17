//
//  BDBAllRoutes.h
//  TravelAppTests
//
//  Created by Bruno Domínguez on 16/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDBAllRoutes : NSObject

@property (strong, nonatomic)NSArray *routes;

-(id)initWithRoutes:(NSArray*)aRoutes;

@end
