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

@interface BDBFlightsTableViewController ()

@end

@implementation BDBFlightsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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
        return @"No flights";
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
    cell.sTimeLabel.text = [NSString stringWithFormat:@"%.2f", [fh sTime]];
    cell.tTimeLabel.text = [NSString stringWithFormat:@"%.2f", [fh tTime]];
    cell.timeTripLabel.text = [NSString stringWithFormat:@"%.2f hours", [fh tTime]/60];
    cell.flightLabel.text = [fh flight];
    cell.airlineLabel.text = [self codeAirline:fh.airline];
    cell.aircraftLabel.text = [self codeAircraft:[fh aircraft]];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSString*)codeAirport:(NSString*)code{
    
    for (BDBAirports *ap in self.airports) {
        if ([code isEqualToString:ap.code]) {
            return ap.name;
        }
    }
    
    return @"No Airport Match";
}

-(NSString*)codeAirline:(NSString*)code{
    
    for (BDBAirlines *al in self.airlines) {
        if ([code isEqualToString:al.code]) {
            return al.name;
        }
    }
    
    return @"No Airline Match";
}

-(NSString*)codeAgency:(NSString*)code{
    
    for (BDBAgencies *ag in self.agencies) {
        if ([code isEqualToString:ag.code]) {
            return ag.name;
        }
    }
    
    return @"No Agency Match";
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
