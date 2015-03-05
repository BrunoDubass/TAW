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

@interface BDBTicketsTableViewController ()

@end

@implementation BDBTicketsTableViewController

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
        
        [[segment itineraries] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [[obj legs]enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [[obj hops]enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                                n+=1;
               }];
            }];
        }];
        return n;
    }
    
}


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

//-(NSArray *)flightTicketData{
//    
//}

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
        cell.timeTrip.text = [NSString stringWithFormat:@"%.2f", tD.timeTrip];
        cell.agency.text = tD.agency;
        cell.frequency.text = [NSString stringWithFormat:@"%.ui", tD.frequency];
  
        
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
