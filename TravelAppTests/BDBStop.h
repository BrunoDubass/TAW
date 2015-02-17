//
//  BDBStop.h
//  TravelAppTests
//
//  Created by Bruno Domínguez on 16/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDBStop : NSObject

@property (copy, nonatomic)NSString *kind;
@property (copy, nonatomic)NSString *name;
@property (copy, nonatomic)NSString *pos;
@property (copy, nonatomic)NSString *code;
@property (copy, nonatomic)NSString *countryCode;
@property (copy, nonatomic)NSString *regionCode;
@property (copy, nonatomic)NSString *timeZone;

-(id)initWithKind:(NSString*)aKind
             name:(NSString*)aName
              pos:(NSString*)aPos
             code:(NSString*)aCode
      countryCode:(NSString*)aCountryCode
       regionCode:(NSString*)aRegionCode
         timeZone:(NSString*)aTimeZone;

@end
