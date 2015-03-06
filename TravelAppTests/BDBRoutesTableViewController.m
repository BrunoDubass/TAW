//
//  BDBRoutesTableViewController.m
//  TravelAppTests
//
//  Created by Bruno Domínguez on 17/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBRoutesTableViewController.h"
#import "BDBRoute.h"
#import "BDBSegmentTableViewController.h"

@interface BDBRoutesTableViewController ()

@property (nonatomic)NSInteger index;

@end

@implementation BDBRoutesTableViewController



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

    // Return the number of rows in the section.
    return self.routesTableRoute.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    BDBRoute *route = self.routesTableRoute[indexPath.row];
    
    cell.textLabel.text = [route name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f horas - %.3f kilómetros - %.2f eur",(route.timeTrip/60), route.distanceR, [[route indicativePrice]price]];
    
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BDBSegmentTableViewController *sVC = [[BDBSegmentTableViewController alloc]init];
    
    sVC.routesTableSegment = [[NSArray alloc]init];
    
    sVC.index = tableView.indexPathForSelectedRow.row;
    sVC.routesTableSegment = _routesTableRoute;
    [self.navigationController pushViewController:sVC animated:YES];
    
}


@end
