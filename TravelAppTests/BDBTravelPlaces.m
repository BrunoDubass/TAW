//
//  BDBTravelPlaces.m
//  TravelAppTests
//
//  Created by Bruno Domínguez on 26/01/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBTravelPlaces.h"

@implementation BDBTravelPlaces

+(instancetype)travelPlacesWithKind:(NSString*)aKind
                               name:(NSString*)aName
                           longName:(NSString*)aLongName
                           position:(NSString*)aPosition
                        countryCode:(NSString*)aCountryCode
                         regionCode:(NSString*)aRegionCode
                           timeZone:(NSString*)aTimeZone{
    
    return [[BDBTravelPlaces alloc]initWithKind:aKind
                                           name:aName
                                       longName:aLongName
                                       position:aPosition
                                    countryCode:aCountryCode
                                     regionCode:aRegionCode
                                       timeZone:aTimeZone];
}

-(id)initWithKind:(NSString*)aKind
             name:(NSString*)aName
         longName:(NSString*)aLongName
         position:(NSString*)aPosition
      countryCode:(NSString*)aCountryCode
       regionCode:(NSString*)aRegionCode
         timeZone:(NSString*)aTimeZone{
    
    if (self = [super init]) {
        _kind = aKind;
        _name = aName;
        _longName = aLongName;
        _pos = aPosition;
        _countryCode = aCountryCode;
        _regionCode = aRegionCode;
        _timeZ = aTimeZone;
    }
    return self;
}

@end
