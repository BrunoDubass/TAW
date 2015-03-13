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
#import "BDBIndicativePrice.h"
#import "BDBAgenciesAndAirlines.h"

@interface BDBFlightsTableViewController (){
    
    NSInteger indexSel;
    NSIndexPath *oldIndexSel;
    __block NSInteger yOffset;
}

@property (nonatomic)CGPoint offset;
@property (nonatomic)CGSize size;
@property (strong, nonatomic)UIImage *logo;

@end

@implementation BDBFlightsTableViewController


#pragma mark - LIFECYCLE

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    indexSel = -1;
    
    self.title = @"FLIGHTS";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - TABLE VIEW DELEGATE & DATA SOURCE

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

           return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([[self.r.segments objectAtIndex:self.segmentIndex] isKindOfClass:[BDBFlightSegment class]]){
        return [[[self.r.segments objectAtIndex:self.segmentIndex]itineraries]count];
    }else{
        return 0;
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if ([[self.r.segments objectAtIndex:self.segmentIndex] isKindOfClass:[BDBFlightSegment class]]){
        
        return @"Flights Available";
    }else{
        return @"No Flights Available";
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

//      BDBFlightsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"flightsCell" forIndexPath:indexPath];
    
        BDBFlightsTableViewCell *cell = [[BDBFlightsTableViewCell alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 37)];
    
    
    
    
//    BDBFlightSegment *fITI = [self.r.segments objectAtIndex:self.segmentIndex];
    BDBFlightItinerary *fI = [[[self.r.segments objectAtIndex:self.segmentIndex]itineraries]objectAtIndex:indexPath.row];
//    BDBFlightLeg *flightLeg = [[[fITI.itineraries objectAtIndex:indexPath.row]legs]objectAtIndex:0];
//    NSArray *hops = [[[fI legs]objectAtIndex:0]hops];
    
    
    //[[cell subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (fI) {
        cell = [self configFlightCell:fI flightCell:cell];
    }
    
    
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Tap expanded cell
    
    if (indexSel == indexPath.row) {
        indexSel = -1;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    //Tap another cell
    }else if(indexSel != -1){
        oldIndexSel = [NSIndexPath indexPathForRow:indexSel inSection:0];
        indexSel = indexPath.row;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:oldIndexSel,indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
        
        
        //No cell expanded
    }else{
        indexSel = indexPath.row;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }

    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexSel == indexPath.row) {
        return yOffset+8;
    }
    return 37;
}

-(BDBFlightsTableViewCell*)configFlightCell:(BDBFlightItinerary*)flightIti flightCell:(BDBFlightsTableViewCell*)cell{
    
    
    BDBFlightSegment *fS = [self.r.segments objectAtIndex:self.segmentIndex];
    BDBFlightLeg *flightLeg = [[flightIti legs]objectAtIndex:0];
    NSArray *hops = [[[flightIti legs]objectAtIndex:0]hops];
    
    yOffset = 8;
    
//    for (UIView *subView in cell.viewForBaselineLayout.subviews)
//    {
//        [subView removeFromSuperview];
//        
//    }
    
//    [[cell subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    
    
    UILabel *from = [[UILabel alloc]initWithFrame:CGRectMake(8, yOffset, 68, 21)];
    UILabel *to = [[UILabel alloc]initWithFrame:CGRectMake(89, yOffset, 68, 21)];
    UILabel *distance = [[UILabel alloc]initWithFrame:CGRectMake(160, yOffset, 119, 21)];
    UILabel *duration = [[UILabel alloc]initWithFrame:CGRectMake(287, yOffset, 84, 21)];
    UILabel *price = [[UILabel alloc]initWithFrame:CGRectMake(379, yOffset, 70, 21)];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(457, yOffset, 23, 27)];
    UIButton *buy = [[UIButton alloc]initWithFrame:CGRectMake(496, yOffset, 73, 30)];
    
    [cell.contentView addSubview:from];
    [cell.contentView addSubview:to];
    [cell.contentView addSubview:distance];
    [cell.contentView addSubview:duration];
    [cell.contentView addSubview:price];
    [cell.contentView addSubview:image];
    [cell.contentView addSubview:buy];
    
        
    from.text = fS.sCode;
    to.text = fS.tCode;
    distance.text = [NSString stringWithFormat:@"%.2f km", fS.distanceR];
    duration.text = [NSString stringWithFormat:@"%2u:%2u", (int)fS.timeTrip/60, (int)fS.timeTrip%60];
    price.text = [NSString stringWithFormat:@"%.2f €", [flightLeg.indicativePrice price]];
    
    buy.titleLabel.text = @"buy";
    
    yOffset+=37;
    
    
    
    // Configure the cell...
    [hops enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        
        UILabel *sCode = [[UILabel alloc]initWithFrame:CGRectMake(8, yOffset, 184, 21)];
        UILabel *sTerminal = [[UILabel alloc]initWithFrame:CGRectMake(200, yOffset, 10, 21)];
        UILabel *sTer = [[UILabel alloc]initWithFrame:CGRectMake(218, yOffset, 29, 21)];
        UILabel *departureTime = [[UILabel alloc]initWithFrame:CGRectMake(255, yOffset, 37, 21)];
        UILabel *sTime = [[UILabel alloc]initWithFrame:CGRectMake(300, yOffset, 50, 21)];
        UILabel *airline = [[UILabel alloc]initWithFrame:CGRectMake(358, yOffset, 220, 21)];
        
        [cell.contentView addSubview:sCode];
        [cell.contentView addSubview:sTerminal];
        [cell.contentView addSubview:sTer];
        [cell.contentView addSubview:departureTime];
        [cell.contentView addSubview:sTime];
        [cell.contentView addSubview:airline];
        
        yOffset+=29;
        
        UILabel *tCode = [[UILabel alloc]initWithFrame:CGRectMake(8, yOffset, 184, 21)];
        UILabel *tTerminal = [[UILabel alloc]initWithFrame:CGRectMake(200, yOffset, 10, 21)];
        UILabel *tTer = [[UILabel alloc]initWithFrame:CGRectMake(218, yOffset, 29, 21)];
        UILabel *arrivalTime = [[UILabel alloc]initWithFrame:CGRectMake(255, yOffset, 37, 21)];
        UILabel *tTime = [[UILabel alloc]initWithFrame:CGRectMake(300, yOffset, 50, 21)];
        UILabel *aircraft = [[UILabel alloc]initWithFrame:CGRectMake(358, yOffset, 220, 21)];
        
        [cell.contentView addSubview:tCode];
        [cell.contentView addSubview:tTerminal];
        [cell.contentView addSubview:tTer];
        [cell.contentView addSubview:arrivalTime];
        [cell.contentView addSubview:tTime];
        [cell.contentView addSubview:aircraft];
        
        yOffset+=39;
        
        sCode.text = [self codeAirport:[obj sCode]];
        sTerminal.text = @"T";
        sTer.text = [obj sTerminal];
        departureTime.text = @"Dep";
        sTime.text = [obj sTime];
        BDBAirlines *a = [self codeAirline:[obj airline]];
        airline.text = a.name;
        tCode.text = [self codeAirport:[obj tCode]];
        tTerminal.text = @"T";
        tTer.text = [obj tTerminal];
        arrivalTime.text = @"Arr";
        tTime.text = [obj tTime];
        aircraft.text = [self codeAircraft:[obj aircraft]];
        
        
        
        if (idx != hops.count-1) {
            
            if (idx == 0) {
                
            }else{
                
            }
        }
        
    }];
    
    cell.clipsToBounds = YES;
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


-(UIImage *) getSprite:(UIImage *)image
{
//    if (self.sprite == nil)
//    {

  
        CGRect rect = CGRectMake(self.offset.x, self.offset.y, self.size.width, self.size.height);
        
        CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
        
        self.logo = [UIImage imageWithCGImage:imageRef];
        
        CGImageRelease(imageRef);
//    }
    
    return self.logo;
}


-(void)setIconOffset:(NSString*)iconOff{
    
    float x,y;
    NSString *string = iconOff;
    if ([string length] > 0)
    {
        NSScanner *scanner = [NSScanner scannerWithString:iconOff];
        [scanner setCharactersToBeSkipped: [NSCharacterSet characterSetWithCharactersInString:@","]];
        [scanner scanFloat:&x];
        [scanner scanFloat:&y];
    }
    else //default icon offset
    {
        x = 0;
        y = 0;
    }
    self.offset = CGPointMake(x, y);
}



@end
