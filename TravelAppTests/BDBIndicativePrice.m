//
//  BDBIndicativePrice.m
//  TravelAppTests
//
//  Created by Bruno Domínguez on 16/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBIndicativePrice.h"

@implementation BDBIndicativePrice

-(id)initWithPrice:(float)aPrice
          currency:(NSString*)aCurrency
    isFreeTransfer:(BOOL)aIsFreeTransfer
       nativePrice:(float)aNativePrice
    nativeCurrency:(NSString*)aNativeCurrency{
    
    if (self = [super init]) {
        _price = aPrice;
        _currency = aCurrency;
        _isFreeTransfer = aIsFreeTransfer;
        _nativePrice = aNativePrice;
        _nativeCurrency = aNativeCurrency;
    }
    return self;
}

@end
