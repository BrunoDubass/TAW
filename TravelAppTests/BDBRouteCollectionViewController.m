//
//  BDBRouteCollectionViewController.m
//  TravelAppTests
//
//  Created by Bruno Domínguez on 24/02/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBRouteCollectionViewController.h"
#import "BDBAllRoutes.h"
#import "BDBRouteCollectionViewCell.h"
#import "BDBIndicativePrice.h"
#import "BDBRoute.h"


@interface BDBRouteCollectionViewController ()

@property (strong, nonatomic)UICollectionViewFlowLayout *layout;

@end

@implementation BDBRouteCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.allRoutes.routes.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BDBRouteCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    
    cell.routeLabel.text = [NSString stringWithFormat:@"%@ - %.2f km - %.2f min - %.2f eur",[[self.allRoutes.routes objectAtIndex:indexPath.row]name], [[self.allRoutes.routes objectAtIndex:indexPath.row]distanceR], [[self.allRoutes.routes objectAtIndex:indexPath.row]timeTrip], [[[self.allRoutes.routes objectAtIndex:indexPath.row]indicativePrice]price]];
    
    
    
    [cell.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>


// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}



// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}





@end
