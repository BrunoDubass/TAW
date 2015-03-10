//
//  BDBAgenciesAndAirlines.m
//  TravelAppTests
//
//  Created by Bruno Domínguez on 04/03/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBAgenciesAndAirlines.h"

@implementation BDBAgenciesAndAirlines

-(id)initWithCode:(NSString*)aCode
             name:(NSString*)aName
              url:(NSString*)aUrl
         iconPath:(NSString*)aIconPath
         iconSize:(float)aIconSize
       iconOffset:(NSString*)aIconOffset{
    
    if (self = [super init]) {
        _code = aCode;
        _name = aName;
        _url = aUrl;
        _iconPath = aIconPath;
        _iconSize = aIconSize;
        _iconOffset = aIconOffset;
    }
    return self;
}

@end
