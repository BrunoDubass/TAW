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

@end
