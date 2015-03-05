//
//  BDBAirports.m
//  TravelAppTests
//
//  Created by Bruno Domínguez on 05/03/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBAirports.h"

@implementation BDBAirports

-(id)initWithCode:(NSString*)aCode
             name:(NSString*)aName
              pos:(NSString*)aPos
      countryCode:(NSString*)aCountryCode
         timeZone:(NSString*)aTimeZone{
    
    if (self = [super init]) {
        _code = aCode;
        _name = aName;
        _pos = aPos;
        _countryCode = aCountryCode;
        _timeZone = aTimeZone;
    }
    return self;
}

@end
