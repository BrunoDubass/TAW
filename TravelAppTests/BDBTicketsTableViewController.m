//
//  BDBTicketsTableViewController.m
//  TravelAppTests
//
//  Created by Bruno Domínguez on 04/03/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBTicketsTableViewController.h"
#import "BDBTicketsTableViewCell.h"
#import "BDBRoute.h"
#import "BDBWalkCarSegment.h"
#import "BDBTransitSegment.h"
#import "BDBFlightSegment.h"
#import "BDBTransitLine.h"
#import "BDBFlightItinerary.h"
#import "BDBTransitItinerary.h"
#import "BDBTransitHop.h"
#import "BDBFlightHop.h"
#import "BDBTransitLeg.h"
#import "BDBFlightLeg.h"
#import "BDBTransitAgency.h"
#import "BDBTransitTicketData.h"
#import "BDBActions.h"
#import "BDBAgenciesAndAirlines.h"
#import "BDBAirports.h"
#import "BDBAgencies.h"
#import "BDBWebViewController.h"

@interface BDBTicketsTableViewController ()

@end

@implementation BDBTicketsTableViewController



#pragma mark - LIFECYCLE

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    self.title = @"TICKETS";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    
}



#pragma mark - TABLE VIEW DELEGATE & DATA SOURCE

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    __block NSInteger n=0;
    id segment = [self.r.segments objectAtIndex:self.segmentIndex];

    if ([segment isKindOfClass:[BDBWalkCarSegment class]]) {
        return 0;
    }else if ([segment isKindOfClass:[BDBTransitSegment class]]){
        
        [[segment itineraries] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [[obj legs]enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [[obj transitHop]enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {

                        [[obj agencies]enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                            [[obj actions]enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                n+=1;
                            }];
                        }];

                }];
    
    
            }];
        }];
        return n;
    }else{
        
        return 0;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BDBTicketsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ticketCell" forIndexPath:indexPath];
    
    
    
    // Configure the cell...
    id segment = [self.r.segments objectAtIndex:self.segmentIndex];
    
    
    if ([segment isKindOfClass:[BDBTransitSegment class]]) {
        
        NSArray *tTD = [self transitTicketData];
        BDBTransitTicketData *tD = [tTD objectAtIndex:indexPath.row];
        
        cell.sName.text = tD.sName;
        cell.tName.text = tD.tName;
        cell.vehicle.text = tD.vehicle;
        cell.timeTrip.text = [NSString stringWithFormat:@"%u:%u", (int)tD.timeTrip/60, (int)tD.timeTrip%60];
        cell.agency.text = [[self codeAgency:tD.agency]name];
        //cell.frequency.text = [NSString stringWithFormat:@"%.ui", tD.frequency];
        [cell.ticketButton setTitle:[NSString stringWithFormat:@"%@",tD.url] forState:UIControlStateNormal];
        
        
    }
    
    
    return cell;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if ([[self.r.segments objectAtIndex:self.segmentIndex] isKindOfClass:[BDBTransitSegment class]]){
        return @"Tickets Available";
    }else{
        return @"No Tickets Available";
    }
    
}





#pragma mark - UTILS


-(NSArray *)transitTicketData{
    
    NSMutableArray *transitTicketData = [[NSMutableArray alloc]init];
    
        BDBTransitSegment *tS = [self.r.segments objectAtIndex:self.segmentIndex];
    
        __block NSString *sName;
        __block NSString *tName;
        __block NSString *vehicle;
        __block NSString *agency;
        __block float timeTrip;
        __block float frequency;
        __block NSURL *url;
        __block NSString *displayUrl;
    
    
        [[tS itineraries] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [[obj legs]enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                
                [[obj transitHop]enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    BDBTransitHop *tH = obj;
                    sName = [tH sName];
                    tName = [tH tName];
                    
                    
                    
                    [[obj lines]enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                        BDBTransitLine *tL = obj;
                        vehicle = [tL vehicle];
                        
                    }];
                    
                    [[obj agencies]enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                        BDBTransitAgency *tA = obj;
                        agency = [tA agency];
                        frequency = [tA frecuency];
                        timeTrip = [tA timeTrip];
                        
                        [[obj actions]enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                            BDBActions *a = obj;
                            url = [a url];
                            displayUrl = [a displayUrl];
                            
                            BDBTransitTicketData *tTD = [[BDBTransitTicketData alloc]initWithSName:sName
                                                                                             tName:tName
                                                                                           vehicle:vehicle
                                                                                            agency:agency
                                                                                         frequency:frequency
                                                                                          timeTrip:timeTrip
                                                                                               url:url
                                                                                        displayUrl:displayUrl];
                            [transitTicketData addObject:tTD];
                        }];
                    }];

                    
                    
                    
                    
                }];
                
            }];
            
            
        }];
        
    
    return transitTicketData;
    
}


-(BDBAgencies*)codeAgency:(NSString*)code{
    
    for (BDBAgencies *ag in self.agencies) {
        if ([code isEqualToString:ag.code]) {
            return ag;
        }
    }
    
    return nil;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"webTicket"]) {
        BDBWebViewController *wVC = [segue destinationViewController];
        NSURL *url = [NSURL URLWithString:[[sender titleLabel]text]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        wVC.request = request;
        
    }
}




@end
