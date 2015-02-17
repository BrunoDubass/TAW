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
#import "BDBActions.h"
#import "BDBAllRoutes.h"
#import "BDBAnnotation.h"
#import "BDBFlightCodeShare.h"
#import "BDBFlightHop.h"
#import "BDBFlightItinerary.h"
#import "BDBFlightLeg.h"
#import "BDBFlightSegment.h"
#import "BDBIndicativePrice.h"
#import "BDBRoute.h"
#import "BDBStop.h"
#import "BDBTransitAgency.h"
#import "BDBTransitHop.h"
#import "BDBTransitItinerary.h"
#import "BDBTransitLeg.h"
#import "BDBTransitLine.h"
#import "BDBTransitSegment.h"
#import "BDBTravelModel.h"
#import "BDBWalkCarSegment.h"
#import "BDBRoutesTableViewController.h"



@interface ViewController ()

@property (strong, nonatomic) NSMutableArray * originArray;
@property (strong, nonatomic) NSMutableArray * destinationArray;
@property (copy, nonatomic  ) NSString       * latitude;
@property (copy, nonatomic  ) NSString       * longitude;
@property (strong, nonatomic) id<MKAnnotation      > pointAnnotation1;
@property (strong, nonatomic) id<MKAnnotation      > pointAnnotation2;
@property (strong, nonatomic) NSMutableArray * routesENC;
@property (strong, nonatomic) NSMutableArray * routesDEC;
@property (strong, nonatomic) MKPolyline     * segmentTest;
@property (strong, nonatomic) NSMutableArray * tempOverlays;





@end

@implementation ViewController

-(void)getDataFromJSON:(NSDictionary*)JSONDic{
    
    [self.allRoutes.routes removeAllObjects];
    
    for (int i = 0; i<[[JSONDic objectForKey:@"routes"]count]; i++) {
        
        NSDictionary *dicRoute        = [[JSONDic objectForKey:@"routes"]objectAtIndex:i];
        NSMutableArray *stopsForRoute = [[NSMutableArray alloc]init];
        NSMutableArray *segments      = [[NSMutableArray alloc]init];
        
        
        
        
        
        
        //STOPS
        
        for (int j = 0; j<[[dicRoute objectForKey:@"stops"]count]; j++) {
            
            BDBStop *stop = [[BDBStop alloc]initWithKind:[[[dicRoute objectForKey:@"stops"]objectAtIndex:j]objectForKey:@"kind"]
                                                    name:[[[dicRoute objectForKey:@"stops"]objectAtIndex:j]objectForKey:@"name"]
                                                     pos:[[[dicRoute objectForKey:@"stops"]objectAtIndex:j]objectForKey:@"pos"]
                                                    code:[[[dicRoute objectForKey:@"stops"]objectAtIndex:j]objectForKey:@"code"]
                                             countryCode:[[[dicRoute objectForKey:@"stops"]objectAtIndex:j]objectForKey:@"countryCode"]
                                              regionCode:[[[dicRoute objectForKey:@"stops"]objectAtIndex:j]objectForKey:@"regionCode"]
                                                timeZone:[[[dicRoute objectForKey:@"stops"]objectAtIndex:j]objectForKey:@"timeZone"]];
            
            [stopsForRoute addObject:stop];
        }
        
        
        
        
        //SEGMENTS
        
        
        
        
        for (int k=0; k<[[dicRoute objectForKey:@"segments"]count]; k++) {
            
            NSDictionary *seg = [[dicRoute objectForKey:@"segments"]objectAtIndex:k];
            NSString *kind    = [seg objectForKey:@"kind"];
            NSMutableArray *itinerariesSegment;
            NSMutableArray *stopsSegment;
            
            BDBIndicativePrice *priceSeg = [[BDBIndicativePrice alloc]initWithPrice:[[[seg objectForKey:@"indicativePrice"]objectForKey:@"price"]floatValue]
                                                                           currency:[[seg objectForKey:@"indicativePrice"]objectForKey:@"currency"]
                                                                     isFreeTransfer:[[[seg objectForKey:@"indicativePrice"]objectForKey:@"isFreeTransfer"] boolValue]
                                                                        nativePrice:[[[seg objectForKey:@"indicativePrice"]objectForKey:@"nativePrice"]floatValue]
                                                                     nativeCurrency:[[seg objectForKey:@"indicativePrice"]objectForKey:@"nativeCurrency"]];
            
            
            
            //     W   A  L  K
            
            
            
            if ([kind isEqualToString:@"walk"]||[kind isEqualToString:@"car"]) {
                
                BDBWalkCarSegment *walk = [[BDBWalkCarSegment alloc]initWithKind:kind
                                                                         subKind: [seg objectForKey:@"subKind"]
                                                                         vehicle:[seg objectForKey:@"vehicle"]
                                                                         isMajor:[[seg objectForKey:@"isMajor"]boolValue]
                                                                      isImperial:[[seg objectForKey:@"isImperial"]boolValue]
                                                                        distance:[[seg objectForKey:@"distance"]floatValue]
                                                                        duration:[[seg objectForKey:@"duration"]floatValue]
                                                                           sName:[seg objectForKey:@"sName"]
                                                                            sPos:[seg objectForKey:@"sPos"]
                                                                           tName:[seg objectForKey:@"tName"]
                                                                            tPos:[seg objectForKey:@"tPos"]
                                                                 indicativePrice:priceSeg
                                                                            path:[seg objectForKey:@"path"]];
                
                
                [segments addObject:walk];
                
                
                
            //   T  R  A  I  N
                
                
                                           
            }else if ([kind isEqualToString:@"train"]||[kind isEqualToString:@"bus"]||[kind isEqualToString:@"ferry"]){
                
                //ITINERARIOS
                
                NSMutableArray *legs = [[NSMutableArray alloc]init];
                
                for (int l=0; l<[[seg objectForKey:@"itineraries"]count]; l++) {
                    
                    NSDictionary *legsIti = [[seg objectForKey:@"itineraries"]objectAtIndex:l];
                    
                    for (int m=0; m<[[legsIti objectForKey:@"legs"]count]; m++) {
                        
                        //HOPS
                        
                        NSMutableArray *hopsIti = [[NSMutableArray alloc]init];
                        
                        for (int n=0; n<[[legsIti objectForKey:@"hops"]count] ; n++) {
                            
                            NSDictionary *dicHop = [[legsIti objectForKey:@"hops"]objectAtIndex:n];
                            
    BDBIndicativePrice *indicativePriceHop = [[BDBIndicativePrice alloc]initWithPrice:[[[dicHop objectForKey:@"indicativePrice"]objectForKey:@"price"]floatValue]
                                                                             currency:[[dicHop objectForKey:@"indicativePrice"]objectForKey:@"currency"]
                                                                       isFreeTransfer:[[[dicHop objectForKey:@"indicativePrice"]objectForKey:@"isFreeTransfer"]boolValue]
                                                                          nativePrice:[[[dicHop objectForKey:@"indicativePrice"]objectForKey:@"nativePrice"]floatValue]
                                                                       nativeCurrency:[[dicHop objectForKey:@"indicativePrice"]objectForKey:@"nativeCurrency"]];
                            
                            NSMutableArray *hopLines;
                            
                            //HOP LINES
                            
                            for (int o=0; o<[[dicHop objectForKey:@"lines"]count]; o++) {
    BDBTransitLine *transitLine = [[BDBTransitLine alloc]initWithName:[[[dicHop objectForKey:@"lines"]objectAtIndex:o]objectForKey:@"name"]
                                                              vehicle:[[[dicHop objectForKey:@"lines"]objectAtIndex:o]objectForKey:@"vehicle"]
                                                                 code:[[[dicHop objectForKey:@"lines"]objectAtIndex:o]objectForKey:@"code"]
                                                               agency:[[[dicHop objectForKey:@"lines"]objectAtIndex:o]objectForKey:@"agency"]
                                                            frecuency:[[[[dicHop objectForKey:@"lines"]objectAtIndex:o]objectForKey:@"frequency"]floatValue]
                                                             duration:[[[[dicHop objectForKey:@"lines"]objectAtIndex:o]objectForKey:@"duration"]floatValue]
                                                                 days:[[[[dicHop objectForKey:@"lines"]objectAtIndex:o]objectForKey:@"days"]floatValue]];
                                
                            [hopLines addObject:transitLine];
                            
                            }
                            
                            //HOP AGENCIES
                            
                            NSMutableArray *hopAgencies;
                            NSMutableArray *agenciesActions;
                            
                            for (int p=0; p<[[dicHop objectForKey:@"agencies"]count]; p++) {
                                
                                
                                
                                for (int q=0; q<[[[[dicHop objectForKey:@"agencies"]objectAtIndex:p]objectForKey:@"actions"]count]; q++) {
                                    
                                    NSDictionary *actionDic = [[[[dicHop objectForKey:@"agencies"]objectAtIndex:p]objectForKey:@"actions"]objectAtIndex:q];
                                    
                                    BDBActions *agAction = [[BDBActions alloc]initWithText:[actionDic objectForKey:@"text"]
                                                                                       url:[actionDic objectForKey:@"url"]
                                                                                displayUrl:[actionDic objectForKey:@"displayUrl"]
                                                                              moustacheUrl:[actionDic objectForKey:@"moustacheUrl"]];
                                    
                                    
                                    [agenciesActions addObject:agAction];
                                }
                                
    BDBTransitAgency *transitAgency = [[BDBTransitAgency alloc]initWithAgency:[[[dicHop objectForKey:@"agencies"]objectAtIndex:p]objectForKey:@"agency"]
                                                                    frecuency:[[[[dicHop objectForKey:@"agencies"]objectAtIndex:p]objectForKey:@"frequency"]integerValue]
                                                                     duration:[[[[dicHop objectForKey:@"agencies"]objectAtIndex:p]objectForKey:@"duration"]integerValue]
                                                                      actions:agenciesActions];
                                
                                [hopAgencies addObject:transitAgency];
                            }
                            
                            
                            BDBTransitHop *hop = [[BDBTransitHop alloc]initWithSName:[dicHop objectForKey:@"sName"]
                                                                                sPos:[dicHop objectForKey:@"sPos"]
                                                                               tName:[dicHop objectForKey:@"tName"]
                                                                                tPos:[dicHop objectForKey:@"tPos"]
                                                                           frecuency:[[dicHop objectForKey:@"frecuency"]floatValue]
                                                                            duration:[[dicHop objectForKey:@"duration"]floatValue]
                                                                     indicativePrice:indicativePriceHop
                                                                               lines:hopLines
                                                  
                                                                            agencies: agenciesActions];
                            
                            [hopsIti addObject:hop];
                        }
                        
                        
                        //LEGS
                        
                        BDBTransitLeg *transitLeg = [[BDBTransitLeg alloc]initWithUrl:[[[legsIti objectForKey:@"legs"]objectAtIndex:m]objectForKey:@"url"]
                                                                                 host: [[[legsIti objectForKey:@"legs"]objectAtIndex:m]objectForKey:@"host"]
                                                                           transitHop:hopsIti];
                        
                        
                        [legs addObject:transitLeg];
                    }
                    
                    BDBTransitItinerary *iti = [[BDBTransitItinerary alloc]initWithLegs:legs];
                    
                    [itinerariesSegment addObject:iti];
                }
                
                BDBTransitSegment *transit = [[BDBTransitSegment alloc]initWithKind:kind
                                                                            subKind:[seg objectForKey:@"subKind"]
                                                                            isMajor:[[seg objectForKey:@"isMajor"]boolValue]
                                                                         isImperial:[[seg objectForKey:@"isImperial"]boolValue]
                                                                           distance:[[seg objectForKey:@"distance"]floatValue]
                                                                           duration:[[seg objectForKey:@"duration"]floatValue]
                                                                   transferDuration:[[seg objectForKey:@"transferDuration"]floatValue]
                                                                              sName:[seg objectForKey:@"sName"] sPos:[seg objectForKey:@"sPos"]
                                                                              tName:[seg objectForKey:@"tName"] tPos:[seg objectForKey:@"tPos"]
                                                                    indicativePrice:priceSeg
                                                                        itineraries:itinerariesSegment
                                                                               path:[seg objectForKey:@"path"]
                                                                              stops:stopsSegment];
                
                
                [segments addObject:transit];
                
                
                
                
                
            //       F  L  I  G  H  T
                
                
                
                
                
            }else{
                
                
                //ITINERARIOS
                
                NSMutableArray *legs = [[NSMutableArray alloc]init];
                
                for (int l=0; l<[[seg objectForKey:@"itineraries"]count]; l++) {
                    
                    NSDictionary *legsIti = [[seg objectForKey:@"itineraries"]objectAtIndex:l]; //Diccionario de itinerario
                    
                    for (int m=0; m<[[legsIti objectForKey:@"legs"]count]; m++) {
                        
                        NSMutableArray *flightHops;
                        
                        
                        //INDICATIVE PRICES
                        
                        
BDBIndicativePrice *indicativeFlightPrice = [[BDBIndicativePrice alloc]initWithPrice:[[[[[legsIti objectForKey:@"legs"]objectAtIndex:m]objectForKey:@"indicativePrice"]         objectForKey:@"price"]floatValue]
                                                                            currency:[[[[legsIti objectForKey:@"legs"]objectAtIndex:m]objectForKey:@"indicativePrice"]objectForKey:@"currency"]
                                                                      isFreeTransfer:[[[[[legsIti objectForKey:@"legs"]objectAtIndex:m]objectForKey:@"indicativePrice"]objectForKey:@"isFreeTransfer"]boolValue]
                                                                         nativePrice:0.0f
                                                                      nativeCurrency:nil];
                        
                        
                        
                        
                        //HOPS
                    
                        
                        for (int a=0; a<[[[[legsIti objectForKey:@"legs"]objectAtIndex:m]objectForKey:@"hops"]count]; a++) {
                            
                            NSDictionary *fDic = [[[[legsIti objectForKey:@"legs"]objectAtIndex:m]objectForKey:@"hops"]objectAtIndex:a];

                            NSMutableArray *codeShares;
                            
                            for (int b=0; b<[[fDic objectForKey:@"codeShares"]count]; b++) {
                                
    BDBFlightCodeShare *fCode = [[BDBFlightCodeShare alloc]initWithAirline:[[[fDic objectForKey:@"codeShares"]objectAtIndex:b]objectForKey:@"airline"]
                                                                    flight:[[[fDic objectForKey:@"codeShares"]objectAtIndex:b]objectForKey:@"flight"]];
                                
                                [codeShares addObject:fCode];
                                
                                }
                            
                                BDBFlightHop *fHop = [[BDBFlightHop alloc]initWithSCode:[fDic objectForKey:@"sCode"]
                                                                                  tCode:[fDic objectForKey:@"tCode"]
                                                                              sTerminal:[fDic objectForKey:@"sTerminal"]
                                                                              tTerminal:[fDic objectForKey:@"tTerminal"]
                                                                                  sTime:[[fDic objectForKey:@"sTime"]floatValue]
                                                                                  tTime:[[fDic objectForKey:@"tTime"]floatValue]
                                                                                 flight:[fDic objectForKey:@"flight"]
                                                                                airline:[fDic objectForKey:@"airline"]
                                                                               duration:[[fDic objectForKey:@"duration"]floatValue]
                                                                               aircraft:[fDic objectForKey:@"aircraft"]
                                                                              codeShare:codeShares
                                                                              dayChange:[[fDic objectForKey:@"dayChange"]integerValue]
                                                                              iDuration:[[fDic objectForKey:@"IDuration"]floatValue]
                                                                             iDayChange:[[fDic objectForKey:@"IDayChange"]integerValue]];
                            
                            
                            
                            [flightHops addObject:fHop];
                        }
                        
                        
                        
                            
                        
                        
                        //LEGS
                        BDBFlightLeg *flightLeg = [[BDBFlightLeg alloc]initWithDays:[[[[legsIti objectForKey:@"legs"]objectAtIndex:m]objectForKey:@"days"]floatValue]
                                                                               hops:flightHops
                                                                   indicativePrices:indicativeFlightPrice];
                        
                        
                        [legs addObject:flightLeg];
                    }
                    
        BDBFlightItinerary *flightIti = [[BDBFlightItinerary alloc]initWithLegs:legs
                                                                       isHidden:[[[[seg objectForKey:@"itineraries"]objectAtIndex:l]objectForKey:@"isHidden"]boolValue]
                                                                       isReturn:[[[[seg objectForKey:@"itineraries"]objectAtIndex:l]objectForKey:@"isReturn"]boolValue]];
                    
                    [itinerariesSegment addObject:flightIti];
                }
                
                BDBFlightSegment *flight = [[BDBFlightSegment alloc]initWithKind:kind
                                                                         isMajor:[[seg objectForKey:@"isMajor"]boolValue]
                                                                        distance:[[seg objectForKey:@"distance"]floatValue]
                                                                        duration:[[seg objectForKey:@"duration"]floatValue]
                                                                transferDuration:[[seg objectForKey:@"transferDuration"]floatValue]
                                                                           sCode:[seg objectForKey:@"sCode"]
                                                                           tCode:[seg objectForKey:@"tCode"]
                                                                 indicativePrice:priceSeg
                                                                     itineraries:itinerariesSegment];
                
                
                
                [segments addObject:flight];
                
                
                
                
            }
        }
        
        
        //LOOP ROUTE
        
        BDBIndicativePrice *indicativePrice = [[BDBIndicativePrice alloc]initWithPrice:[[[dicRoute objectForKey:@"indicativePrice"]objectForKey:@"price"]floatValue]
                                                                              currency:[[dicRoute objectForKey:@"indicativePrice"]objectForKey:@"currency"]
                                                                        isFreeTransfer:[[[dicRoute objectForKey:@"indicativePrice"]objectForKey:@"isFreeTransfer"]boolValue]
                                                                           nativePrice:0.0f
                                                                        nativeCurrency:nil];
        
        
        BDBRoute *route = [[BDBRoute alloc]initWithName:[dicRoute objectForKey:@"name"]
                                               distance:[[dicRoute objectForKey:@"distance"]floatValue]
                                               duration:[[dicRoute objectForKey:@"duration"]floatValue]
                                                  stops: stopsForRoute
                                               segments: segments
                                        indicativePrice: indicativePrice];
        
        
        
        [self.allRoutes.routes addObject:route];
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.allRoutes = [[BDBAllRoutes alloc]init];
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

#pragma mark - CONVERSIONS

//GOOGLE MAPS COORDS A APPLE MAPS COORDS

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

//GPSSTRING TO CLLOCATION2D

-(void)convertGPSStringToCLLocation2d:(NSString*)pos{
    
    NSRange coma = [pos rangeOfString:@","];
    int comaPos = (int) coma.location;
    
    self.latitude = [pos substringWithRange:NSMakeRange(0, comaPos)];
    self.longitude = [pos substringWithRange:NSMakeRange(comaPos+1, [pos length]-(comaPos+1))];
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
                                                                            countryCode:[dic objectForKey:@"countryCode"]
                                                                             regionCode:[dic objectForKey:@"regionCode"]
                                                                               timeZone:[dic objectForKey:@"timeZone"]]];
                    
                }
                
                [self.routesENC removeAllObjects];
                [self.mapViewOrigin removeAnnotation:self.pointAnnotation1];
                [self.mapViewOrigin removeAnnotation:self.pointAnnotation2];
                
                //ORIGIN
                
                [self convertGPSStringToCLLocation2d:[[self.places.places objectAtIndex:0]pos]];
                
                NSLog(@"%f", self.latitude.floatValue);
                NSLog(@"%f", self.longitude.floatValue);
                
                self.pointAnnotation1 = [[BDBAnnotation alloc]initWithName:[[self.places.places objectAtIndex:0]longName]
                                                                coordinate:CLLocationCoordinate2DMake([self.latitude floatValue], [self.longitude floatValue])];

                
                [self.mapViewOrigin addAnnotation:self.pointAnnotation1];
                
                
                
                
                //DESTINY
                
                [self convertGPSStringToCLLocation2d:[[self.places.places objectAtIndex:1]pos]];
                NSLog(@"%f", self.latitude.floatValue);
                NSLog(@"%f", self.longitude.floatValue);
                
                self.pointAnnotation2 = [[BDBAnnotation alloc]initWithName:[[self.places.places objectAtIndex:1]longName]
                                                                coordinate:CLLocationCoordinate2DMake([self.latitude floatValue], [self.longitude floatValue])];
                
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
                
                
                
                // D A T A  F R O M  J S O N
                
                
                [self getDataFromJSON:jsonDictionary];
                
               
                
                
                
                
                
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
    
    NSString* url   = [NSString stringWithFormat:@"http://free.rome2rio.com/api/1.2/json/Autocomplete?key=MG6NfQmt&query=%@", self.originSearch.text];
    NSString* urlOk = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL* nsurl    = [NSURL URLWithString:urlOk];
    NSData* data    = [NSData dataWithContentsOfURL:nsurl];
    NSError* error  = nil;
    
    NSDictionary* jasonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    NSArray* arrayPlaces          = [jasonDictionary objectForKey:@"places"];
    
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
    
    NSString* url   = [NSString stringWithFormat:@"http://free.rome2rio.com/api/1.2/json/Autocomplete?key=MG6NfQmt&query=%@", self.destinationSearch.text];
    NSString* urlOk = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL* nsurl    = [NSURL URLWithString:urlOk];
    NSData* data    = [NSData dataWithContentsOfURL:nsurl];
    NSError* error  = nil;
    
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
    
    self.originKind.text             = [[self.places.places objectAtIndex:0]kind];
    self.originName.text             = [[self.places.places objectAtIndex:0]name];
    self.originLongName.text         = [[self.places.places objectAtIndex:0]longName];
    self.originPosition.text         = [[self.places.places objectAtIndex:0]pos];
    self.originCountryCode.text      = [[self.places.places objectAtIndex:0]countryCode];
    self.originRegionCode.text       = [[self.places.places objectAtIndex:0]regionCode];
    self.originTimeZone.text         = [[self.places.places objectAtIndex:0]timeZ];

    self.destinationKind.text        = [[self.places.places objectAtIndex:1]kind];
    self.destinationName.text        = [[self.places.places objectAtIndex:1]name];
    self.destinationLongName.text    = [[self.places.places objectAtIndex:1]longName];
    self.destinationPosition.text    = [[self.places.places objectAtIndex:1]pos];
    self.destinationCountryCode.text = [[self.places.places objectAtIndex:1]countryCode];
    self.destinationRegionCode.text  = [[self.places.places objectAtIndex:1]regionCode];
    self.destinationTimeZone.text    = [[self.places.places objectAtIndex:1]timeZ];

    
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"routes"]) {
        BDBRoutesTableViewController *rVC = [segue destinationViewController];
        rVC.routesTable = self.allRoutes.routes;
    }
    
}

             

@end
