//
//  BDBStop.m
//  TravelAppTests
//
//  Created by Bruno Domínguez on 16/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBStop.h"

@implementation BDBStop

-(id)initWithKind:(NSString*)aKind
             name:(NSString*)aName
              pos:(NSString*)aPos
             code:(NSString*)aCode
      countryCode:(NSString*)aCountryCode
       regionCode:(NSString*)aRegionCode
         timeZone:(NSString*)aTimeZone{
    
    if (self = [super init]) {
        
        _kind = aKind;
        _name = aName;
        _pos = aPos;
        _code = aCode;
        _countryCode = aCountryCode;
        _regionCode = aRegionCode;
        _timeZone = aTimeZone;
    }
    
    return self;
}

@end
