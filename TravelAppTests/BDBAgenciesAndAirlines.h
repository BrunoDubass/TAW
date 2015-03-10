//
//  BDBAgenciesAndAirlines.h
//  TravelAppTests
//
//  Created by Bruno Domínguez on 04/03/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDBAgenciesAndAirlines : NSObject

@property (copy, nonatomic)NSString * code;
@property (copy, nonatomic)NSString * name;
@property (copy, nonatomic)NSString * url;
@property (copy, nonatomic)NSString * iconPath;
@property (nonatomic)float iconSize;
@property (nonatomic)NSString *iconOffset;

-(id)initWithCode:(NSString*)aCode
             name:(NSString*)aName
              url:(NSString*)aUrl
         iconPath:(NSString*)aIconPath
         iconSize:(NSString*)aIconSize
       iconOffset:(float)aIconOffset;

@end
