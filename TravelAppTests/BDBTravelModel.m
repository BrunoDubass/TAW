//
//  BDBTravelModel.m
//  TravelAppTests
//
//  Created by Bruno Domínguez on 26/01/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBTravelModel.h"

@implementation BDBTravelModel

-(id)init{
    
    if (self = [super init]) {
        _places = [[NSMutableArray alloc]init];
    }
    return self;
}

@end
