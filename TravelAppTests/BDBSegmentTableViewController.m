//
//  BDBSegmentTableViewController.m
//  TravelAppTests
//
//  Created by Bruno Domínguez on 18/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBSegmentTableViewController.h"
#import "BDBRoute.h"
#import "BDBStop.h"
#import "BDBFlightSegment.h"
#import "BDBFlightItinerary.h"
#import "BDBWalkCarSegment.h"
#import "BDBTransitSegment.h"
#import "BDBFlightLeg.h"

@interface BDBSegmentTableViewController ()

@end

@implementation BDBSegmentTableViewController



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
    //[[self.routesTable[self.index]stops]count]
    return [[self.routesTableSegment[self.index]stops]count];
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSArray *stop = [[self.routesTableSegment objectAtIndex:self.index ] stops];
    return [[stop objectAtIndex:section]name];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //section-=1;

    // Return the number of rows in the section.
        
    BDBRoute *selectedRoute = [self.routesTableSegment objectAtIndex:self.index];
    
    if (section == [[[self.routesTableSegment objectAtIndex:self.index]stops]count]-1) {
        return 0;
    }
    
    if ([[[selectedRoute segments]objectAtIndex:section]isKindOfClass:[BDBWalkCarSegment class]]) {
        return 1;
    }else if ([[[selectedRoute segments]objectAtIndex:section]isKindOfClass:[BDBTransitSegment class]]){
        return 1;
    }else{
        return 1;
    
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    
    id seg = [[self.routesTableSegment[self.index]segments]objectAtIndex:indexPath.section];
    
    
    
    if ([[seg kind]isEqualToString:@"walk"]||[[seg kind]isEqualToString:@"car"]) {
        
        cell.textLabel.text = [NSString stringWithFormat:@"%.2f horas   %.2f km   %@   %@ - %@   Precio: %.2f eur", [seg timeTrip]/60, [seg distance], [seg vehicle], [seg sName], [seg tName], [[seg indicativePrice]price]];
        return cell;
        
    }else if([[seg kind]isEqualToString:@"train"]||[[seg kind]isEqualToString:@"bus"]||[[seg kind]isEqualToString:@"ferry"]){
        
        //NSArray *stops = [[[self.routesTableSegment[self.index]segments]objectAtIndex:indexPath.section]stops];
        
            cell.textLabel.text = [NSString stringWithFormat:@"%.2f horas   %.2f km   %@ - %@   Precio: %.2f eur", [seg timeTrip]/60, [seg distance], [seg sName], [seg tName], [[seg indicativePrice]price]];
            
      
        return cell;
        
    }else{
        
        
        cell.textLabel.text = [NSString stringWithFormat:@"%.2f horas   %.2f km   %@ - %@   Precio: %.2f eur", [seg timeTrip]/60, [seg distance], [seg sCode], [seg tCode], [[seg indicativePrice]price]];
        
        return cell;
    }

    
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
