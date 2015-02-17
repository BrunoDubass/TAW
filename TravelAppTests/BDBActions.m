//
//  BDBActions.m
//  TravelAppTests
//
//  Created by Bruno Domínguez on 16/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBActions.h"

@implementation BDBActions

-(id)initWithText:(NSString*)aText
              url:(NSURL*)aUrl
       displayUrl:(NSString*)aDisplayUrl
     moustacheUrl:(NSURL*)aMoustacheUrl{
    
    if (self = [super init]) {
        _text = aText;
        _url = aUrl;
        _displayUrl = aDisplayUrl;
        _moustacheUrl = aMoustacheUrl;
    }
    return self;
}

@end
