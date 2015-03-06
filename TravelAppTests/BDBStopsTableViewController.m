//
//  BDBStopsTableViewController.m
//  TravelAppTests
//
//  Created by Bruno Domínguez on 03/03/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBStopsTableViewController.h"
#import "BDBRoute.h"
#import "BDBFlightSegment.h"
#import "BDBStop.h"
#import "BDBTransitSegment.h"
#import "BDBWalkCarSegment.h"
#import "BDBAirports.h"

@interface BDBStopsTableViewController ()

@end

@implementation BDBStopsTableViewController


#pragma mark - LIFECYCLE

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

    if ([[self.r.segments objectAtIndex:self.stopsIndex]isKindOfClass:[BDBWalkCarSegment class]]||[[self.r.segments objectAtIndex:self.stopsIndex]isKindOfClass:[BDBFlightSegment class]]) {
        return 2;
    }else{
        return [[[self.r.segments objectAtIndex:self.stopsIndex]stops]count];
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"stopsCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"stopsCell"];
    }
    NSMutableArray *walkStops = [[NSMutableArray alloc]init];
    BDBStop *wc;
    // Configure the cell...
    if ([[self.r.segments objectAtIndex:self.stopsIndex]isKindOfClass:[BDBWalkCarSegment class]]||[[self.r.segments objectAtIndex:self.stopsIndex]isKindOfClass:[BDBFlightSegment class]]) {
        for (NSUInteger i=self.stopsIndex; i<self.stopsIndex+2; i++) {
            wc = [self.r.stops objectAtIndex:i];
            [walkStops addObject:wc];
        }
        cell.textLabel.text = [[walkStops objectAtIndex:indexPath.row]name];
        cell.detailTextLabel.text = [[walkStops objectAtIndex:indexPath.row]kind];
        
    }else
        
//        if ([[self.r.segments objectAtIndex:self.stopsIndex]isKindOfClass:[BDBFlightSegment class]])
        {
         
             cell.textLabel.text = [[[[self.r.segments objectAtIndex:self.stopsIndex]stops]objectAtIndex:indexPath.row]name];
             cell.detailTextLabel.text = [[[[self.r.segments objectAtIndex:self.stopsIndex]stops]objectAtIndex:indexPath.row]kind];
            
        
    }
    return cell;
}


@end
