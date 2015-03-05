//
//  BDBAircrafts.m
//  TravelAppTests
//
//  Created by Bruno Domínguez on 05/03/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBAircrafts.h"

@implementation BDBAircrafts

-(id)initWithCode:(NSString*)aCode
     manufacturer:(NSString*)aManufacturer
            model:(NSString*)aModel{
    
    if (self =[super init]) {
        _code = aCode;
        _manufacturer = aManufacturer;
        _model = aModel;
    }
    return self;
}

@end
