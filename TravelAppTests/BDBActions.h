//
//  BDBActions.h
//  TravelAppTests
//
//  Created by Bruno Domínguez on 16/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDBActions : NSObject

@property (copy, nonatomic)NSString *text;
@property (strong, nonatomic)NSURL *url;
@property (copy, nonatomic)NSString *displayUrl;
@property (strong, nonatomic)NSURL *moustacheUrl;

-(id)initWithText:(NSString*)aText
              url:(NSURL*)aUrl
       displayUrl:(NSString*)aDisplayUrl
     moustacheUrl:(NSURL*)aMoustacheUrl;

@end
