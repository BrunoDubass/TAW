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
#import "BDBInfoViewController.h"
#import "BDBRouteCollectionViewController.h"
#import "BDBRouteViewController.h"
#import "BDBAgencies.h"
#import "BDBAirlines.h"
#import "BDBAirports.h"
#import "BDBAircrafts.h"





@interface ViewController ()

@property (strong, nonatomic) NSMutableArray * originArray;
@property (strong, nonatomic) NSMutableArray * destinationArray;
@property (copy, nonatomic  ) NSString       * latitude;
@property (copy, nonatomic  ) NSString       * longitude;

@property (copy, nonatomic  ) NSString       * latitudeA;
@property (copy, nonatomic  ) NSString       * longitudeA;
@property (copy, nonatomic  ) NSString       * latitudeB;
@property (copy, nonatomic  ) NSString       * longitudeB;


@property (strong, nonatomic) id<MKAnnotation      > pointAnnotation1;
@property (strong, nonatomic) id<MKAnnotation      > pointAnnotation2;
@property (strong, nonatomic) NSMutableArray * routesENC;
@property (strong, nonatomic) NSMutableArray * routesDEC;
@property (strong, nonatomic) MKPolyline     * segmentTest;
@property (strong, nonatomic) NSMutableArray * tempOverlays;

@property (strong, nonatomic) NSMutableArray *routesArray;

@property (strong, nonatomic) NSArray *agencies;
@property (strong, nonatomic) NSArray *airlines;
@property (strong, nonatomic) NSArray *airports;
@property (strong, nonatomic) NSArray *aircrafts;

@property (nonatomic)BOOL segueOk;





@end

@implementation ViewController




#pragma mark - LIFECYCLE


- (void)viewDidLoad {
    [super viewDidLoad];
    self.allRoutes = [[BDBAllRoutes alloc]init];
    self.routesENC = [[NSMutableArray alloc]init];
    self.routesDEC = [[NSMutableArray alloc]init];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.title = @"SELECT ORIGIN AND DESTINATION";
    
    [super viewWillAppear:animated];
    
    self.originTableView.scrollEnabled = YES;
    self.originTableView.hidden = YES;
    
    self.destinationTableView.scrollEnabled = YES;
    self.destinationTableView.hidden = YES;
    
    self.originSearch.delegate = self;
    self.destinationSearch.delegate = self;
    
    //self.tempOverlays = [NSMutableArray new];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark - DATA FROM JSON



-(void)getDataFromJSON:(NSDictionary*)JSONDic{
    
    [self.allRoutes.routes removeAllObjects];
    
    
    
    
    
    //AIRCRAFTS
    
    NSArray *aircraftsArray = [JSONDic objectForKey:@"aircrafts"];
    NSMutableArray *aircraftsMutable = [[NSMutableArray alloc]init];
    [aircraftsArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        BDBAircrafts *aircraft = [[BDBAircrafts alloc]initWithCode:[obj objectForKey:@"code"]
                                                      manufacturer:[obj objectForKey:@"manufacturer"]
                                                             model:[obj objectForKey:@"model"]];
        
        [aircraftsMutable addObject:aircraft];
    }];
    
    self.aircrafts = aircraftsMutable;

    
    
    
    
    
    
    //AIRPORTS
    
    NSArray *airportsArray = [JSONDic objectForKey:@"airports"];
    NSMutableArray *airportsMutable = [[NSMutableArray alloc]init];
    [airportsArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        BDBAirports *airport = [[BDBAirports alloc]initWithCode:[obj objectForKey:@"code"]
                                                           name:[obj objectForKey:@"name"]
                                                            pos:[obj objectForKey:@"pos"]
                                                    countryCode:[obj objectForKey:@"countryCode"]
                                                       timeZone:[obj objectForKey:@"timeZone"]];
        
        
        [airportsMutable addObject:airport];
    }];
    
    self.airports = airportsMutable;
    
    
    //AGENCIES
    NSArray *agenciesArray = [JSONDic objectForKey:@"agencies"];
    NSMutableArray *agenciesMutable = [[NSMutableArray alloc]init];
    [agenciesArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        BDBAgencies *agencie = [[BDBAgencies alloc]initWithCode:[obj objectForKey:@"code"]
                                                           name:[obj objectForKey:@"name"]
                                                            url:[obj objectForKey:@"url"]
                                                       iconPath:[obj objectForKey:@"iconPath"]
                                                       iconSize:[obj objectForKey:@"iconSize"]
                                                     iconOffset:[[obj objectForKey:@"iconOffset"]floatValue]];
        
        
        [agenciesMutable addObject:agencie];
    }];
    
    self.agencies = agenciesMutable;
    
    //AIRLINES
    NSArray *airlinesArray = [JSONDic objectForKey:@"airlines"];
    NSMutableArray *airlinesMutable = [[NSMutableArray alloc]init];
    [airlinesArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        BDBAirlines *airline = [[BDBAirlines alloc]initWithCode:[obj objectForKey:@"code"]
                                                           name:[obj objectForKey:@"name"]
                                                            url:[obj objectForKey:@"url"]
                                                       iconPath:[obj objectForKey:@"iconPath"]
                                                       iconSize:[obj objectForKey:@"iconSize"]
                                                     iconOffset:[[obj objectForKey:@"iconOffset"]floatValue]];
        
        
        [airlinesMutable addObject:airline];
    }];
    
    self.airlines = airlinesMutable;

    
    //ROUTES
    NSArray *route = [JSONDic objectForKey:@"routes"];
    
    
    [route enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        //STOPS
        NSArray *stops = [[route objectAtIndex:idx ] objectForKey:@"stops"];
        NSMutableArray *stopsMutable = [[NSMutableArray alloc]init];
        
        [stops enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            BDBStop *stp = [[BDBStop alloc]initWithKind:[obj objectForKey:@"kind"]
                                                   name:[obj objectForKey:@"name"]
                                                    pos:[obj objectForKey:@"pos"]
                                                   code:[obj objectForKey:@"code"]
                                            countryCode:[obj objectForKey:@"countryCode"]
                                             regionCode:[obj objectForKey:@"regionCode"]
                                               timeZone:[obj objectForKey:@"timeZone"]];
            
            [stopsMutable addObject:stp];
            
        }]; //END STOPS
        
        //SEGMENTS
        NSArray *segments = [[route objectAtIndex:idx] objectForKey:@"segments"];
        NSMutableArray *segmentsMutable = [[NSMutableArray alloc]init];
        
        [segments enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            //WALK CAR SEGMENT
            if ([[obj objectForKey:@"kind"]isEqualToString:@"walk"]||[[obj objectForKey:@"kind"]isEqualToString:@"car"]) {
                
                BDBIndicativePrice *indicativePrice = [[BDBIndicativePrice alloc]initWithPrice:[[[obj objectForKey:@"indicativePrice"]objectForKey:@"price"]floatValue]
                                                                                      currency:[[obj objectForKey:@"indicativePrice"]objectForKey:@"currency"]
                                                                                isFreeTransfer:[[[obj objectForKey:@"indicativePrice"]objectForKey:@"isFreeTransfer"]boolValue]
                                                                                   nativePrice:[[[obj objectForKey:@"indicativePrice"]objectForKey:@"nativePrice"]floatValue]
                                                                                nativeCurrency:[[obj objectForKey:@"indicativePrice"]objectForKey:@"nativeCurrency"]];
                
                BDBWalkCarSegment *walkSegment = [[BDBWalkCarSegment alloc]initWithKind:[obj objectForKey:@"kind"]
                                                                                subKind:[obj objectForKey:@"subKind"]
                                                                                vehicle:[obj objectForKey:@"vehicle"]
                                                                                isMajor:[[obj objectForKey:@"isMajor"]boolValue]
                                                                             isImperial:[[obj objectForKey:@"isImperial"]boolValue]
                                                                               distance:[[obj objectForKey:@"distance"]floatValue]
                                                                               timeTrip:[[obj objectForKey:@"duration"]floatValue]
                                                                                  sName:[obj objectForKey:@"sName"]
                                                                                   sPos:[obj objectForKey:@"sPos"]
                                                                                  tName:[obj objectForKey:@"tName"]
                                                                                   tPos:[obj objectForKey:@"tPos"]
                                                                        indicativePrice:indicativePrice
                                                                                   path:[obj objectForKey:@"path"]];
                
                [segmentsMutable addObject:walkSegment];
            
            
            //TRANSIT SEGMENT
       }else if ([[obj objectForKey:@"kind"]isEqualToString:@"train"]||[[obj objectForKey:@"kind"]isEqualToString:@"bus"]||[[obj objectForKey:@"kind"]isEqualToString:@"ferry"]){
            
                
           
                 NSMutableArray *transitStopsMutable = [[NSMutableArray alloc]init];

                //TRANSIT STOPS
                
                NSArray *transitStops = [obj objectForKey:@"stops"];

                
                [transitStops enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    
                    BDBStop *transitStop = [[BDBStop alloc]initWithKind:[obj objectForKey:@"kind"]
                                                                   name:[obj objectForKey:@"name"]
                                                                    pos:[obj objectForKey:@"pos"]
                                                                   code:[obj objectForKey:@"code"]
                                                            countryCode:[obj objectForKey:@"countryCode"]
                                                             regionCode:[obj objectForKey:@"regionCode"]
                                                               timeZone:[obj objectForKey:@"timeZone"]];
                    
                    [transitStopsMutable addObject:transitStop];
                }];
           
                NSMutableArray *itinerariesMutable = [[NSMutableArray alloc]init];

                //TRANSIT ITINERARIES
                NSArray *itineraries = [obj objectForKey:@"itineraries"];
                
                //ARRAYS

                
                
                NSMutableArray *transitLegsMutable = [[NSMutableArray alloc]init];
                NSMutableArray *transitHopsMutable = [[NSMutableArray alloc]init];
                NSMutableArray *linesMutable = [[NSMutableArray alloc]init];
                NSMutableArray *agenciesMutable = [[NSMutableArray alloc]init];
                NSMutableArray *transitActionsMutable = [[NSMutableArray alloc]init];

                [itineraries enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    
                    BDBTransitItinerary *transitItinerary = [[BDBTransitItinerary alloc]initWithLegs:transitLegsMutable];
                    
                    [itinerariesMutable addObject:transitItinerary];
                    
                    //TRANSIT LEGS
                    NSArray *transitLegs = [obj objectForKey:@"legs"];

                    
                    [transitLegsMutable removeAllObjects];
                    
                    [transitLegs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                        
                        BDBTransitLeg *transitLeg = [[BDBTransitLeg alloc]initWithUrl:[obj objectForKey:@"url"]
                                                                                 host: [obj objectForKey:@"host"]
                                                                           transitHop:transitHopsMutable];
                        
                        [transitLegsMutable addObject:transitLeg];
                        
                        //TRANSIT HOP
                        NSArray *transitHop = [obj objectForKey:@"hops"];
                        
                        [transitHopsMutable removeAllObjects];
                        
                        [transitHop enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {

                            
        BDBIndicativePrice *indicativePrice = [[BDBIndicativePrice alloc]initWithPrice:[[[obj objectForKey:@"indicativePrice"]objectForKey:@"price"]floatValue]
                                                                              currency:[[obj objectForKey:@"indicativePrice"]objectForKey:@"currency"]
                                                                        isFreeTransfer:[[[obj objectForKey:@"indicativePrice"]objectForKey:@"isFreeTransfer"]boolValue]
                                                                           nativePrice:[[[obj objectForKey:@"indicativePrice"]objectForKey:@"nativePrice"]floatValue]
                                                                        nativeCurrency:[[obj objectForKey:@"indicativePrice"]objectForKey:@"nativeCurrency"]];

                            BDBTransitHop *tHop = [[BDBTransitHop alloc]initWithSName:[obj objectForKey:@"sName"]
                                                                                 sPos:[obj objectForKey:@"sPos"]
                                                                                tName:[obj objectForKey:@"tName"]
                                                                                 tPos:[obj objectForKey:@"tPos"]
                                                                            frecuency:[[obj objectForKey:@"frequency"]floatValue]
                                                                             timeTrip:[[obj objectForKey:@"duration"]floatValue]
                                                                      indicativePrice:indicativePrice
                                                                                lines:linesMutable
                                                                             agencies:agenciesMutable];
                            
                            
                            [transitHopsMutable addObject:tHop];
                            
                                //TRANSIT LINES
                                NSArray *lines = [obj objectForKey:@"lines"];
                            
                                [linesMutable removeAllObjects];

                                [lines enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                    
                                    BDBTransitLine *tLine = [[BDBTransitLine alloc]initWithName:[obj objectForKey:@"name"]
                                                                                        vehicle:[obj objectForKey:@"vehicle"]
                                                                                           code:[obj objectForKey:@"code"]
                                                                                         agency:[obj objectForKey:@"agency"]
                                                                                      frecuency:[[obj objectForKey:@"frequency"]floatValue]
                                                                                       timeTrip:[[obj objectForKey:@"duration"]floatValue]
                                                                                           days:[[obj objectForKey:@"days"]floatValue]];
                                    
                                    
                                    
                                    [linesMutable addObject:tLine];
                                }];
                            
                                //TRANSIT AGENCIES
                            NSArray *agencies = [obj objectForKey:@"agencies"];
                            
                            [agenciesMutable removeAllObjects];

                            [agencies enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                
                                BDBTransitAgency *tAgencie = [[BDBTransitAgency alloc]initWithAgency:[obj objectForKey:@"agency"]
                                                                                           frecuency:[[obj objectForKey:@"frequency"]integerValue]
                                                                                            timeTrip:[[obj objectForKey:@"duration"]integerValue]
                                                                                             actions:transitActionsMutable];
                                
                                
                                [agenciesMutable addObject:tAgencie];
                                
                                    //TRANSIT ACTIONS
                                NSArray *transitActions = [obj objectForKey:@"actions"];
                                
                                [transitActionsMutable removeAllObjects];
                                
                                [transitActions enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                    
                                    BDBActions *tAction = [[BDBActions alloc]initWithText:[obj objectForKey:@"text"]
                                                                                      url:[obj objectForKey:@"url"]
                                                                               displayUrl:[obj objectForKey:@"displayUrl"]
                                                                             moustacheUrl:[obj objectForKey:@"moustacheUrl"]];
                                    
                                    [transitActionsMutable addObject:tAction];
                                }];

                            }];
                            
                            
                            
                        }];
                   }];
                }];
           
           
                BDBIndicativePrice *indicativePrice = [[BDBIndicativePrice alloc]initWithPrice:[[[obj objectForKey:@"indicativePrice"]objectForKey:@"price"]floatValue]
                                                                                      currency:[[obj objectForKey:@"indicativePrice"]objectForKey:@"currency"]
                                                                                isFreeTransfer:[[[obj objectForKey:@"indicativePrice"]objectForKey:@"isFreeTransfer"]boolValue]
                                                                                   nativePrice:[[[obj objectForKey:@"indicativePrice"]objectForKey:@"nativePrice"]floatValue]
                                                                                nativeCurrency:[[obj objectForKey:@"indicativePrice"]objectForKey:@"nativeCurrency"]];
           
                BDBTransitSegment *transitSegment = [[BDBTransitSegment alloc]initWithKind:[obj objectForKey:@"kind"]
                                                                                   subKind:[obj objectForKey:@"subKind"]
                                                                                   isMajor:[[obj objectForKey:@"isMajor"]boolValue]
                                                                                isImperial:[[obj objectForKey:@"isImperial"]boolValue]
                                                                                  distance:[[obj objectForKey:@"distance"]floatValue]
                                                                                  timeTrip:[[obj objectForKey:@"duration"]floatValue]
                                                                          transferDuration:[[obj objectForKey:@"transferDuration"]floatValue]
                                                                                     sName:[obj objectForKey:@"sName"]
                                                                                      sPos:[obj objectForKey:@"sPos"]
                                                                                     tName:[obj objectForKey:@"tName"]
                                                                                      tPos:[obj objectForKey:@"tPos"]
                                                                           indicativePrice:indicativePrice
                                                                               itineraries: itinerariesMutable
                                                                                      path:[obj objectForKey:@"path"]
                                                                                     stops:transitStopsMutable];
           
           
                
                [segmentsMutable addObject:transitSegment];
            
            //FLIGHT SEGMENT
           }else{
               
               
               
               //FLIGHT ITINERARIES
               
               NSArray *flightItineraries = [obj objectForKey:@"itineraries"];
               NSMutableArray *flightItinerariesMutable = [[NSMutableArray alloc]init];
               
               [flightItineraries enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                   
                   
                   //FLIGHT LEGS
                   NSArray *flightLegs = [obj objectForKey:@"legs"];
                   NSMutableArray *flightLegsMutable = [[NSMutableArray alloc]init];
                   
                   [flightLegs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                       
                       
                       //FLIGHT HOPS
                       
                       NSArray *flightHops = [obj objectForKey:@"hops"];
                       NSMutableArray *flightHopsMutable = [[NSMutableArray alloc]init];
                       
                       [flightHops enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                           
                           
                           
                           
                           BDBFlightHop *flightHop = [[BDBFlightHop alloc]initWithSCode:[obj objectForKey:@"sCode"]
                                                                                  tCode:[obj objectForKey:@"tCode"]
                                                                              sTerminal:[obj objectForKey:@"sTerminal"]
                                                                              tTerminal:[obj objectForKey:@"tTerminal"]
                                                                                  sTime:[obj objectForKey:@"sTime"]
                                                                                  tTime:[obj objectForKey:@"tTime"]
                                                                                 flight:[obj objectForKey:@"flight"]
                                                                                airline:[obj objectForKey:@"airline"]
                                                                               timeTrip:[[obj objectForKey:@"duration"]floatValue]
                                                                               aircraft:[obj objectForKey:@"aircraft"]
                                                                              codeShare:nil
                                                                              dayChange:[[obj objectForKey:@"dayChange"]integerValue]
                                                                              iDuration:[[obj objectForKey:@"IDuration"]floatValue]
                                                                             iDayChange:[[obj objectForKey:@"IDayChange"]integerValue]];
                           
                           [flightHopsMutable addObject:flightHop];
                           
                       }]; //END FLIGHT HOPS
                       
                       
            BDBIndicativePrice *flightLegIndicativePrice = [[BDBIndicativePrice alloc]initWithPrice:[[[obj objectForKey:@"indicativePrice"]objectForKey:@"price"]floatValue]
                                                                                           currency:[[obj objectForKey:@"indicativePrice"]objectForKey:@"currency"]
                                                                                     isFreeTransfer:[[[obj objectForKey:@"indicativePrice"]objectForKey:@"isFreeTransfer"]boolValue]
                                                                                        nativePrice:[[[obj objectForKey:@"indicativePrice"]objectForKey:@"nativePrice"]floatValue]
                                                                                     nativeCurrency:[[obj objectForKey:@"indicativePrice"]objectForKey:@"nativeCurrency"]];
                       
                       
                       BDBFlightLeg *flightLeg = [[BDBFlightLeg alloc]initWithDays:[[obj objectForKey:@"days"]floatValue]
                                                                              hops:flightHopsMutable
                                                                  indicativePrices:flightLegIndicativePrice];
                       [flightLegsMutable addObject:flightLeg];
                       
                   }]; //END FLIGHT LEGS
                   
                   
                   BDBFlightItinerary *flightItinerary = [[BDBFlightItinerary alloc]initWithLegs:flightLegsMutable
                                                                                        isHidden:[[obj objectForKey:@"isHidden"]boolValue]
                                                                                        isReturn:[[obj objectForKey:@"isReturn"]boolValue]];
                   
                   [flightItinerariesMutable addObject:flightItinerary];
                   
               }]; //END FLIGHT ITINERARIES
               
               //FLIGHT INDICATIVE PRICE
               
BDBIndicativePrice *indicativePriceFlight = [[BDBIndicativePrice alloc]initWithPrice:[[[obj objectForKey:@"indicativePrice"]objectForKey:@"price"]floatValue]
                                                                                           currency:[[obj objectForKey:@"indicativePrice"]objectForKey:@"currency"]
                                                                                     isFreeTransfer:[[[obj objectForKey:@"indicativePrice" ]objectForKey:@"isFreeTransfer"]boolValue]
                                                                                        nativePrice:[[[obj objectForKey:@"indicativePrice" ]objectForKey:@"nativePrice"]floatValue]
                                                                                     nativeCurrency:[[obj objectForKey:@"indicativePrice" ]objectForKey:@"nativeCurrency"]];
               
               BDBFlightSegment *flightSegment = [[BDBFlightSegment alloc]initWithKind:[obj objectForKey:@"kind"]
                                                                               isMajor:[[obj objectForKey:@"isMajor"]boolValue]
                                                                              distance:[[obj objectForKey:@"distance"]floatValue]
                                                                              timeTrip:[[obj objectForKey:@"duration"]floatValue]
                                                                      transferDuration:[[obj objectForKey:@"transferDuration"]floatValue]
                                                                                 sCode:[obj objectForKey:@"sCode"]
                                                                                 tCode:[obj objectForKey:@"tCode"]
                                                                       indicativePrice:indicativePriceFlight
                                                                           itineraries:flightItinerariesMutable
                                                                                 index:idx];
               
               [segmentsMutable addObject:flightSegment];
               
            }// END FLIGHT SEGMENT
            
           
        }]; //END SEGMENTS
        
        //INDICATIVE PRICE
        
        BDBIndicativePrice *indicativePriceRoute = [[BDBIndicativePrice alloc]initWithPrice:[[[obj objectForKey:@"indicativePrice"]objectForKey:@"price"]floatValue]
                                                                                   currency:[[obj objectForKey:@"indicativePrice"]objectForKey:@"currency"]
                                                                             isFreeTransfer:[[[obj objectForKey:@"indicativePrice"]objectForKey:@"isFreeTransfer"]boolValue]
                                                                                nativePrice:[[[obj objectForKey:@"indicativePrice"]objectForKey:@"nativePrice"]floatValue]
                                                                             nativeCurrency:[[obj objectForKey:@"indicativePrice"]objectForKey:@"nativeCurrency"]];
        
        
        
        
       BDBRoute *route = [[BDBRoute alloc]initWithName:[obj objectForKey:@"name"]
                                              distance:[[obj objectForKey:@"distance"]floatValue]
                                              timeTrip:[[obj objectForKey:@"duration"]floatValue]
                                                 stops: stopsMutable
                                              segments:segmentsMutable
                                       indicativePrice:indicativePriceRoute];
        
        
    
        
        [self.allRoutes.routes addObject:route];
    
    }]; //END ROUTES
    
    
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

//GPSSTRING TO 2 CLLOCATION2D

-(void)convertGPSStringToCLLocation2dA:(NSString*)posA CLLocation2dB:(NSString*)posB{
    
    NSRange comaA = [posA rangeOfString:@","];
    int comaPosA = (int) comaA.location;
    
    self.latitudeA = [posA substringWithRange:NSMakeRange(0, comaPosA)];
    self.longitudeA = [posA substringWithRange:NSMakeRange(comaPosA+1, [posA length]-(comaPosA+1))];
    
    NSRange comaB = [posB rangeOfString:@","];
    int comaPosB = (int) comaB.location;
    
    self.latitudeB = [posB substringWithRange:NSMakeRange(0, comaPosB)];
    self.longitudeB = [posB substringWithRange:NSMakeRange(comaPosB+1, [posB length]-(comaPosB+1))];

    
    
}


#pragma mark - SEARCH


- (IBAction)search:(id)sender {
    
    self.segueOk = NO;
    
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

                
                //ORIGIN
                
                [self convertGPSStringToCLLocation2d:[[self.places.places objectAtIndex:0]pos]];
                
                
                
                self.pointAnnotation1 = [[BDBAnnotation alloc]initWithName:[[self.places.places objectAtIndex:0]longName]
                                                                coordinate:CLLocationCoordinate2DMake([self.latitude floatValue], [self.longitude floatValue])];

                
                
                
                //DESTINY
                
                [self convertGPSStringToCLLocation2d:[[self.places.places objectAtIndex:1]pos]];
                
                
                self.pointAnnotation2 = [[BDBAnnotation alloc]initWithName:[[self.places.places objectAtIndex:1]longName]
                                                                coordinate:CLLocationCoordinate2DMake([self.latitude floatValue], [self.longitude floatValue])];
                

//                self.originSearch.text =@"";
//                self.destinationSearch.text = @"";
                
                
                
                // D A T A  F R O M  J S O N
                
                
                [self getDataFromJSON:jsonDictionary];
                
                self.segueOk = YES;
                
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


#pragma mark - AUTOCOMPLETE

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




#pragma mark - TABLEVIEW DELEGATE & DATA SOURCE

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    

    
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
            [self performSegueWithIdentifier:@"tab" sender:self];
                    }
        self.originTableView.hidden = YES;
        return [textField resignFirstResponder];

        
    }else{
        if (!([self.originSearch.text isEqualToString:@""]||[self.destinationSearch.text isEqualToString:@""])) {
            [self search:nil];
            [self performSegueWithIdentifier:@"tab" sender:self];
            
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

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    
    if ([identifier isEqualToString:@"tab"]&& self.segueOk == NO) {
        return NO;
    }else
        return YES;
}



#pragma mark - NAVIGATION

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"tab"]) {
        UITabBarController *tabbar = [segue destinationViewController];
        BDBInfoViewController *iVC1 = [tabbar.viewControllers objectAtIndex:0];
        BDBRouteViewController *iVC2 = [tabbar.viewControllers objectAtIndex:1];
        
        
        
        
        iVC1.longName = [[self.places.places objectAtIndex:1]longName];
        iVC1.kind = [[self.places.places objectAtIndex:1]kind];
        iVC1.pos = [[self.places.places objectAtIndex:1]pos];
        iVC1.countryCode = [[self.places.places objectAtIndex:1]countryCode];
        iVC1.regionCode = [[self.places.places objectAtIndex:1]regionCode];
        iVC1.timeZone = [[self.places.places objectAtIndex:1]timeZ];

        
        iVC2.allRoutes = self.allRoutes;
        iVC2.pointAnnotation1 = self.pointAnnotation1;
        iVC2.pointAnnotation2 = self.pointAnnotation2;
        iVC2.agencies = self.agencies;
        iVC2.airlines = self.airlines;
        iVC2.airports = self.airports;
        iVC2.aircrafts = self.aircrafts;
        
         }
    
   
    
    
    
    
}


@end
