//
//  BDBTravelPlaces.h
//  TravelAppTests
//
//  Created by Bruno Domínguez on 26/01/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDBTravelPlaces : NSObject

@property (copy, nonatomic)NSString* kind;
@property (copy, nonatomic)NSString* name;
@property (copy, nonatomic)NSString* longName;
@property (copy, nonatomic)NSString* pos;
@property (copy, nonatomic)NSString* countryCode;
@property (copy, nonatomic)NSString* regionCode;
@property (copy, nonatomic)NSString* timeZ;

+(instancetype)travelPlacesWithKind:(NSString*)aKind
                               name:(NSString*)aName
                           longName:(NSString*)aLongName
                           position:(NSString*)aPosition
                        countryCode:(NSString*)aCountryCode
                         regionCode:(NSString*)aRegionCode
                           timeZone:(NSString*)aTimeZone;

-(id)initWithKind:(NSString*)aKind
             name:(NSString*)aName
         longName:(NSString*)aLongName
         position:(NSString*)aPosition
      countryCode:(NSString*)aCountryCode
       regionCode:(NSString*)aRegionCode
         timeZone:(NSString*)aTimeZone;

@end
