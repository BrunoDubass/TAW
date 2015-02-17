//
//  BDBAllRoutes.m
//  TravelAppTests
//
//  Created by Bruno Domínguez on 16/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBAllRoutes.h"

@implementation BDBAllRoutes

-(id)initWithRoutes:(NSArray*)aRoutes{
    
    if (self = [super init]) {
        
        _routes = aRoutes;
    }
    return self;
}

@end
