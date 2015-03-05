//
//  BDBAircrafts.h
//  TravelAppTests
//
//  Created by Bruno Domínguez on 05/03/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDBAircrafts : NSObject

@property (copy, nonatomic)NSString *code;
@property (copy, nonatomic)NSString *manufacturer;
@property (copy, nonatomic)NSString *model;

-(id)initWithCode:(NSString*)aCode
     manufacturer:(NSString*)aManufacturer
            model:(NSString*)aModel;

@end
