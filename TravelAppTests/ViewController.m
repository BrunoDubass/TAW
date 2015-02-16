//
//  ViewController.m
//  TravelAppTests
//
//  Created by Bruno Domínguez on 26/01/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "ViewController.h"
#import "BDBTravelPlaces.h"
#import "BDBTravelModel.h"
#import "BDBAnnotation.h"


@interface ViewController ()

@property (strong, nonatomic)NSMutableArray* originArray;
@property (strong, nonatomic)NSMutableArray* destinationArray;
@property (copy, nonatomic)NSString* latitude;
@property (copy, nonatomic)NSString* longitude;
@property (strong, nonatomic)id<MKAnnotation> pointAnnotation1;
@property (strong, nonatomic)id<MKAnnotation> pointAnnotation2;
@property (strong, nonatomic)NSMutableArray* routesENC;
@property (strong, nonatomic)NSMutableArray* routesDEC;
@property (strong, nonatomic)MKPolyline * segmentTest;
@property (strong, nonatomic)NSMutableArray* tempOverlays;


@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.routesENC = [[NSMutableArray alloc]init];
    self.routesDEC = [[NSMutableArray alloc]init];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.originTableView.scrollEnabled = YES;
    self.originTableView.hidden = YES;
    
    self.destinationTableView.scrollEnabled = YES;
    self.destinationTableView.hidden = YES;
    
    self.originSearch.delegate = self;
    self.destinationSearch.delegate = self;
    self.mapViewOrigin.delegate = self;
    
    self.tempOverlays = [NSMutableArray new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MKPolyline *)polylineWithEncodedString:(NSString *)encodedString {
    const char *bytes = [encodedString UTF8String];
    NSUInteger length = [encodedString lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    NSUInteger idx = 0;
    
    NSUInteger count = length / 4;
    CLLocationCoordinate2D *coords = calloc(count, sizeof(CLLocationCoordinate2D));
    NSUInteger coordIdx = 0;
    
    float latitude = 0;
    float longitude = 0;
    while (idx < length) {
        char byte = 0;
        int res = 0;
        char shift = 0;
        
        do {
            byte = bytes[idx++] - 63;
            res |= (byte & 0x1F) << shift;
            shift += 5;
        } while (byte >= 0x20);
        
        float deltaLat = ((res & 1) ? ~(res >> 1) : (res >> 1));
        latitude += deltaLat;
        
        shift = 0;
        res = 0;
        
        do {
            byte = bytes[idx++] - 0x3F;
            res |= (byte & 0x1F) << shift;
            shift += 5;
        } while (byte >= 0x20);
        
        float deltaLon = ((res & 1) ? ~(res >> 1) : (res >> 1));
        longitude += deltaLon;
        
        float finalLat = latitude * 1E-5;
        float finalLon = longitude * 1E-5;
        
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(finalLat, finalLon);
        coords[coordIdx++] = coord;
        
        if (coordIdx == count) {
            NSUInteger newCount = count + 10;
            coords = realloc(coords, newCount * sizeof(CLLocationCoordinate2D));
            count = newCount;
        }
    }
    
    MKPolyline *polyline = [MKPolyline polylineWithCoordinates:coords count:coordIdx];
    free(coords);
    
    return polyline;
}


- (IBAction)search:(id)sender {
    
    if ([self.originSearch.text  isEqual: @""] || [self.destinationSearch.text  isEqual: @""]) {
        
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Warning!!"
                                                       message:@"You must select an origin and a destination"
                                                      delegate:self
                                             cancelButtonTitle:@"Ok"
                                             otherButtonTitles: nil];
        [alert show];
        
    }else{
        
        NSString* url = [NSString stringWithFormat:@"http://free.rome2rio.com/api/1.2/json/Search?key=MG6NfQmt&oName=%@&dName=%@", self.originSearch.text, self.destinationSearch.text];
        
        NSString* urlOk = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSURL* nsurl = [NSURL URLWithString:urlOk];
        
        NSError* error = nil;
        
        NSData* data = [NSData dataWithContentsOfURL:nsurl];
        
        if (data != nil) {
            NSDictionary* jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            if (jsonDictionary != nil) {
                
                self.places = [[BDBTravelModel alloc]init];
                
                for (NSDictionary* dic in [jsonDictionary objectForKey:@"places"]) {

                    [self.places.places addObject:[BDBTravelPlaces travelPlacesWithKind:[dic objectForKey:@"kind"]
                                                                           name:[dic objectForKey:@"name"]
                                                                       longName:[dic objectForKey:@"longName"]
                                                                       position:[dic objectForKey:@"pos"]
                                                                    countryCode:[dic objectForKey:@"countryCode"]regionCode:[dic objectForKey:@"regionCode"] timeZone:[dic objectForKey:@"timeZone"]]];
                    
                }
                
                [self.routesENC removeAllObjects];
                [self.mapViewOrigin removeAnnotation:self.pointAnnotation1];
                [self.mapViewOrigin removeAnnotation:self.pointAnnotation2];
                
                //ORIGIN
                
                [self convertGPSStringToCLLocation2d:[[self.places.places objectAtIndex:0]pos]];
                NSLog(@"%f", self.latitude.floatValue);
                NSLog(@"%f", self.longitude.floatValue);
                
                self.pointAnnotation1 = [[BDBAnnotation alloc]initWithName:[[self.places.places objectAtIndex:0]longName] coordinate:CLLocationCoordinate2DMake([self.latitude floatValue], [self.longitude floatValue])];
                
                [self.mapViewOrigin addAnnotation:self.pointAnnotation1];
                
                
                
                
                //DESTINY
                
                [self convertGPSStringToCLLocation2d:[[self.places.places objectAtIndex:1]pos]];
                NSLog(@"%f", self.latitude.floatValue);
                NSLog(@"%f", self.longitude.floatValue);
                
                self.pointAnnotation2 = [[BDBAnnotation alloc]initWithName:[[self.places.places objectAtIndex:1]longName] coordinate:CLLocationCoordinate2DMake([self.latitude floatValue], [self.longitude floatValue])];
                
                [self.mapViewOrigin addAnnotation:self.pointAnnotation2];
                

                
                
                //ROUTES ENCODED
                
                
                for (int i = 0; i<[[jsonDictionary objectForKey:@"routes"]count]; i++) {
                    
                    [self.routesENC addObject:[[jsonDictionary objectForKey:@"routes"]objectAtIndex:i]];
 
                }
                
                //[self.mapViewOrigin removeOverlay:self.segmentTest];
                for (int x = 0; x<self.tempOverlays.count; x++) {
                    [self.mapViewOrigin removeOverlay:[self.tempOverlays objectAtIndex:x]];
                }
                [self.tempOverlays removeAllObjects];
                
                for (int i = 0; i<self.routesENC.count; i++) {
                    
                    NSDictionary* aux;
                    for (int j = 0; j<[[[self.routesENC objectAtIndex:i]objectForKey:@"segments"]count]; j++) {
                        aux = [[[self.routesENC objectAtIndex:i]objectForKey:@"segments"]objectAtIndex:j];
                        [self.mapViewOrigin addOverlay:[self polylineWithEncodedString:[aux objectForKey:@"path"]]];
                        if([aux objectForKey:@"path"] != nil){
                            [self.tempOverlays addObject:[aux objectForKey:@"path"]];
                        }
                        
                    }
                }
                
                NSLog(@"%lu", (unsigned long)[self.routesENC count]);
                NSLog(@"%@", [[[[self.routesENC objectAtIndex:0]objectForKey:@"segments"]objectAtIndex:0]objectForKey:@"path"]);
                
                
                
               
                
                

                
                
                [self showResults];
                self.originSearch.text =@"";
                self.destinationSearch.text = @"";
                
                
                
            }else{
                
                UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Warning"
                                                               message:@"Can´t read contents from jsonDictionary"
                                                              delegate:self
                                                     cancelButtonTitle:@"Ok"
                                                     otherButtonTitles: nil];
                [alert show];

            }
        }else{
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Warning"
                                                           message:@"Can´t read contents from URL"
                                                          delegate:self
                                                 cancelButtonTitle:@"Ok"
                                                 otherButtonTitles: nil];
            
                [alert show];
        }

        
        
        
        
            }
    
}

- (IBAction)originAutoComplete:(id)sender {
    
    NSString* url = [NSString stringWithFormat:@"http://free.rome2rio.com/api/1.2/json/Autocomplete?key=MG6NfQmt&query=%@", self.originSearch.text];
    NSString* urlOk = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL* nsurl = [NSURL URLWithString:urlOk];
    NSData* data = [NSData dataWithContentsOfURL:nsurl];
    NSError* error = nil;
    
    NSDictionary* jasonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    NSArray* arrayPlaces = [jasonDictionary objectForKey:@"places"];
    self.originArray = [[NSMutableArray alloc]init];
    
    for (NSDictionary* dic in arrayPlaces) {
        [self.originArray addObject:[dic objectForKey:@"longName"]];
                                     
    }
    [self.originArray sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    self.originTableView.hidden = NO;
    [self.originTableView reloadData];
    if ([self.originSearch.text isEqualToString:@""]) {
        self.originArray = nil;
        self.originTableView.hidden = YES;
    }
    
}

- (IBAction)destinationAutoComplete:(id)sender {
    
    NSString* url = [NSString stringWithFormat:@"http://free.rome2rio.com/api/1.2/json/Autocomplete?key=MG6NfQmt&query=%@", self.destinationSearch.text];
    NSString* urlOk = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL* nsurl = [NSURL URLWithString:urlOk];
    NSData* data = [NSData dataWithContentsOfURL:nsurl];
    NSError* error = nil;
    
    NSDictionary* jasonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    NSArray* arrayPlaces = [jasonDictionary objectForKey:@"places"];
    self.destinationArray = [[NSMutableArray alloc]init];
    
    for (NSDictionary* dic in arrayPlaces) {
        [self.destinationArray addObject:[dic objectForKey:@"longName"]];
        
    }
    [self.destinationArray sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    self.destinationTableView.hidden = NO;
    [self.destinationTableView reloadData];
    if ([self.destinationSearch.text isEqualToString:@""]) {
        self.destinationArray = nil;
        self.destinationTableView.hidden = YES;
    }

}


-(void)showResults{
    
    self.originKind.text = [[self.places.places objectAtIndex:0]kind];
    self.originName.text = [[self.places.places objectAtIndex:0]name];
    self.originLongName.text = [[self.places.places objectAtIndex:0]longName];
    self.originPosition.text = [[self.places.places objectAtIndex:0]pos];
    self.originCountryCode.text = [[self.places.places objectAtIndex:0]countryCode];
    self.originRegionCode.text = [[self.places.places objectAtIndex:0]regionCode];
    self.originTimeZone.text = [[self.places.places objectAtIndex:0]timeZ];
    
    self.destinationKind.text = [[self.places.places objectAtIndex:1]kind];
    self.destinationName.text = [[self.places.places objectAtIndex:1]name];
    self.destinationLongName.text = [[self.places.places objectAtIndex:1]longName];
    self.destinationPosition.text = [[self.places.places objectAtIndex:1]pos];
    self.destinationCountryCode.text = [[self.places.places objectAtIndex:1]countryCode];
    self.destinationRegionCode.text = [[self.places.places objectAtIndex:1]regionCode];
    self.destinationTimeZone.text = [[self.places.places objectAtIndex:1]timeZ];

    
}

#pragma mark - TABLEVIEW DELEGATE & DATA SOURCE

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.originTableView) {
        return 1;
    }else{
        return 1;
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.originTableView) {
        return [self.originArray count];
    }else{
        return [self.destinationArray count];
    }
    
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellId = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    if (tableView == self.originTableView) {
        cell.textLabel.text = [self.originArray objectAtIndex:indexPath.row];
    }else{
        cell.textLabel.text = [self.destinationArray objectAtIndex:indexPath.row];
    }
    
    NSLog(@"%@", cell);
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.originTableView) {
        self.originSearch.text = [self.originArray objectAtIndex:indexPath.row];
        self.originTableView.hidden = YES;
        [self textFieldShouldReturn:self.originSearch];
    }else{
        self.destinationSearch.text = [self.destinationArray objectAtIndex:indexPath.row];
        self.destinationTableView.hidden = YES;
        [self textFieldShouldReturn:self.destinationSearch];
    }
    
    
}

#pragma mark - UITEXTFIELD DELEGATE

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == self.originSearch) {
        
        if (!([self.originSearch.text isEqualToString:@""]||[self.destinationSearch.text isEqualToString:@""])) {
            [self search:nil];
        }
        self.originTableView.hidden = YES;
        return [textField resignFirstResponder];

        
    }else{
        if (!([self.originSearch.text isEqualToString:@""]||[self.destinationSearch.text isEqualToString:@""])) {
            [self search:nil];
        }
        self.destinationTableView.hidden = YES;
        return [textField resignFirstResponder];
        
    }
    
    
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    if (textField == self.originSearch) {
        
        if (!([self.originSearch.text isEqualToString:@""]||[self.destinationSearch.text isEqualToString:@""])) {
            [self search:nil];
        }
        self.originTableView.hidden = YES;
        return YES;
        
        
    }else{
        if (!([self.originSearch.text isEqualToString:@""]||[self.destinationSearch.text isEqualToString:@""])) {
            [self search:nil];
        }
        self.destinationTableView.hidden = YES;
        return YES;
        
    }
}

-(void)convertGPSStringToCLLocation2d:(NSString*)pos{
    
    NSRange coma = [pos rangeOfString:@","];
    int comaPos = coma.location;
    
    self.latitude = [pos substringWithRange:NSMakeRange(0, comaPos)];
    self.longitude = [pos substringWithRange:NSMakeRange(comaPos+1, [pos length]-(comaPos+1))];
}

#pragma mark - MAP DELEGATE

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay {
    static int contador = 0;
    contador++;
    MKPolylineRenderer *polyline = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    
    if (contador %2 == 0) {
        polyline.strokeColor = [UIColor redColor];
        polyline.lineWidth = 3.0;
    }else{
    polyline.strokeColor = [UIColor blueColor];
    polyline.lineWidth = 3.0;
    }
    return polyline;
}



             

@end
