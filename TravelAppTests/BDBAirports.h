//
//  BDBAirports.h
//  TravelAppTests
//
//  Created by Bruno Domínguez on 05/03/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDBAirports : NSObject

@property (copy, nonatomic)NSString *code;
@property (copy, nonatomic)NSString *name;
@property (copy, nonatomic)NSString *pos;
@property (copy, nonatomic)NSString *countryCode;
@property (copy, nonatomic)NSString *timeZone;

-(id)initWithCode:(NSString*)aCode
             name:(NSString*)aName
              pos:(NSString*)aPos
      countryCode:(NSString*)aCountryCode
         timeZone:(NSString*)aTimeZone;

@end
