//
//  BDBRouteViewController.m
//  TravelAppTests
//
//  Created by Bruno Domínguez on 24/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBRouteViewController.h"
#import "BDBAllRoutes.h"
#import "BDBRouteCollectionViewCell.h"
#import "BDBIndicativePrice.h"
#import "BDBRoute.h"

@interface BDBRouteViewController ()

@end

@implementation BDBRouteViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.allRoutes.routes.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BDBRouteCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    
    cell.routeLabel.text = [NSString stringWithFormat:@"%@ - %.2f km - %.2f min - %.2f eur",[[self.allRoutes.routes objectAtIndex:indexPath.row]name], [[self.allRoutes.routes objectAtIndex:indexPath.row]distanceR], [[self.allRoutes.routes objectAtIndex:indexPath.row]timeTrip], [[[self.allRoutes.routes objectAtIndex:indexPath.row]indicativePrice]price]];
    
    
    
    
    return cell;
}


@end
