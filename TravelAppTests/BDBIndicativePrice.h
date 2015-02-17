//
//  BDBIndicativePrice.h
//  TravelAppTests
//
//  Created by Bruno Domínguez on 16/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDBIndicativePrice : NSObject

@property (nonatomic)float price;
@property (copy, nonatomic)NSString *currency;
@property (nonatomic)BOOL isFreeTransfer;
@property (nonatomic)float nativePrice;
@property (copy, nonatomic)NSString *nativeCurrency;

-(id)initWithPrice:(float)aPrice
          currency:(NSString*)aCurrency
    isFreeTransfer:(BOOL)aIsFreeTransfer
       nativePrice:(float)aNativePrice
    nativeCurrency:(NSString*)aNativeCurrency;

@end
