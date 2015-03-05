//
//  BDBTransitTicketData.h
//  TravelAppTests
//
//  Created by Bruno Domínguez on 05/03/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDBTransitTicketData : NSObject

@property (copy, nonatomic)NSString *sName;
@property (copy, nonatomic)NSString *tName;
@property (copy, nonatomic)NSString *vehicle;
@property (copy, nonatomic)NSString *agency;
@property (nonatomic)NSInteger frequency;
@property (nonatomic)float timeTrip;
@property (copy, nonatomic)NSURL *url;
@property (copy, nonatomic)NSString *displayUrl;

-(id)initWithSName:(NSString*)aSName
             tName:(NSString*)aTName
           vehicle:(NSString*)aVehicle
            agency:(NSString*)aAgency
         frequency:(NSInteger)aFrequency
          timeTrip:(float)aTimeTrip
               url:(NSURL*)aUrl
        displayUrl:(NSString*)aDisplayUrl;

@end
