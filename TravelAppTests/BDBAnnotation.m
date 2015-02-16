//
//  BDBAnnotation.m
//  TravelAppTests
//
//  Created by Bruno Domínguez on 05/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBAnnotation.h"

@implementation BDBAnnotation

-(id)initWithName:(NSString*)longName
       coordinate:(CLLocationCoordinate2D)coord{
    
    if (self = [super init]) {
        _title = longName;
        _coordinate = coord;
    }
    return  self;
}

#pragma mark - MKANNOTATION

@synthesize coordinate = _coordinate;
@synthesize title = _title;
@synthesize subtitle = _subtitle;

@end
