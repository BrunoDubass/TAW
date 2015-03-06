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



#pragma mark - LIFECYCLE

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



#pragma mark - TABLE VIEW DELEGATE & DATA SOURCE

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [[self.routesTableSegment[self.index]stops]count];
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSArray *stop = [[self.routesTableSegment objectAtIndex:self.index ] stops];
    return [[stop objectAtIndex:section]name];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
        
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
        
        cell.textLabel.text = [NSString stringWithFormat:@"%.2f horas   %.2f km   %@   %@ - %@   Precio: %.2f eur", [seg timeTrip]/60, [seg distanceR], [seg vehicle], [seg sName], [seg tName], [[seg indicativePrice]price]];
        return cell;
        
    }else if([[seg kind]isEqualToString:@"train"]||[[seg kind]isEqualToString:@"bus"]||[[seg kind]isEqualToString:@"ferry"]){
        
        
        
            cell.textLabel.text = [NSString stringWithFormat:@"%.2f horas   %.2f km   %@ - %@   Precio: %.2f eur", [seg timeTrip]/60, [seg distanceR], [seg sName], [seg tName], [[seg indicativePrice]price]];
            
      
        return cell;
        
    }else{
        
        
        cell.textLabel.text = [NSString stringWithFormat:@"%.2f horas   %.2f km   %@ - %@   Precio: %.2f eur", [seg timeTrip]/60, [seg distanceR], [seg sCode], [seg tCode], [[seg indicativePrice]price]];
        
        return cell;
    }

    
}



@end
