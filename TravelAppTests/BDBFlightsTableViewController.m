//
//  BDBFlightsTableViewController.m
//  TravelAppTests
//
//  Created by Bruno Domínguez on 05/03/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBFlightsTableViewController.h"
#import "BDBRoute.h"
#import "BDBFlightSegment.h"
#import "BDBFlightLeg.h"
#import "BDBFlightHop.h"
#import "BDBFlightItinerary.h"
#import "BDBFlightsTableViewCell.h"
#import "BDBAirports.h"
#import "BDBAirlines.h"
#import "BDBAgencies.h"
#import "BDBAircrafts.h"
#import "BDBWebViewController.h"

@interface BDBFlightsTableViewController ()

@end

@implementation BDBFlightsTableViewController


#pragma mark - LIFECYCLE

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    self.title = @"FLIGHTS";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - TABLE VIEW DELEGATE & DATA SOURCE

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    if ([[self.r.segments objectAtIndex:self.segmentIndex] isKindOfClass:[BDBFlightSegment class]]) {
        return [[[self.r.segments objectAtIndex:self.segmentIndex]itineraries]count];
    }else{
        return 1;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    __block NSInteger n = 0;
    
    if ([[self.r.segments objectAtIndex:self.segmentIndex] isKindOfClass:[BDBFlightSegment class]]){
    BDBFlightSegment *fS = [self.r.segments objectAtIndex:self.segmentIndex];
    [[[[fS itineraries]objectAtIndex:section]legs]enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [[obj hops]enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            n+=1;
        }];
    }];
    }
    return n;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if ([[self.r.segments objectAtIndex:self.segmentIndex] isKindOfClass:[BDBFlightSegment class]]){
        
        return [NSString stringWithFormat:@"Flight %u - %@ (%@) - %@ (%@)", section+1, [self codeAirport:[[self.r.segments objectAtIndex:self.segmentIndex]sCode]], [[self.r.segments objectAtIndex:self.segmentIndex]sCode],[self codeAirport:[[self.r.segments objectAtIndex:self.segmentIndex]tCode]],[[self.r.segments objectAtIndex:self.segmentIndex]tCode]];
    }else{
        return @"No Flights Available";
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BDBFlightsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"flightsCell" forIndexPath:indexPath];
    
    // Configure the cell...
    BDBFlightHop *fh = [[[[[[[self.r.segments objectAtIndex:self.segmentIndex]itineraries]objectAtIndex:indexPath.section]legs]objectAtIndex:0]hops]objectAtIndex:indexPath.row];
  
    
    cell.sCodeLabel.text = [self codeAirport:[fh sCode]];
    cell.tCodeLabel.text = [self codeAirport:[fh tCode]];
    cell.sTerminalLabel.text = [fh sTerminal];
    cell.tTerminalLabel.text = [fh tTerminal];
    cell.sTimeLabel.text = [NSString stringWithFormat:@"%@", [fh sTime]];
    cell.tTimeLabel.text = [NSString stringWithFormat:@"%@", [fh tTime]];
    cell.timeTripLabel.text = [NSString stringWithFormat:@"%u.%u h", (int)[fh timeTrip]/60, (int)[fh timeTrip]%60];
    cell.flightLabel.text = [fh flight];
    cell.airlineLabel.text = [[self codeAirline:fh.airline]name];
    cell.aircraftLabel.text = [self codeAircraft:[fh aircraft]];
    cell.logoFlight.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.rome2rio.com%@",[[self codeAirline:fh.airline]iconPath]]]]];
    [cell.webUrlButton setTitle:[[self codeAirline:fh.airline]url] forState:UIControlStateNormal];
    
    
    return cell;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"webSegue"]) {
        BDBWebViewController *wVC = [segue destinationViewController];
        NSURL *url = [NSURL URLWithString:[[sender titleLabel]text]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        wVC.request = request;
    }
   
}


#pragma mark - UTILS


-(NSString*)codeAirport:(NSString*)code{
    
    for (BDBAirports *ap in self.airports) {
        if ([code isEqualToString:ap.code]) {
            return ap.name;
        }
    }
    
    return @"No Airport Match";
}

-(BDBAirlines*)codeAirline:(NSString*)code{
    
    for (BDBAirlines *al in self.airlines) {
        if ([code isEqualToString:al.code]) {
            return al;
        }
    }
    
    return nil;
}


-(NSString*)codeAircraft:(NSString*)code{
    
    for (BDBAircrafts *ac in self.aircrafts) {
        if ([code isEqualToString:ac.code]) {
            return [NSString stringWithFormat:@"%@ %@", ac.manufacturer, ac.model];
        }
    }
    
    return @"No Aircraft Match";
}




@end
