//
//  BDBWebViewController.m
//  TravelAppTests
//
//  Created by Bruno Domínguez on 05/03/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import "BDBWebViewController.h"

@interface BDBWebViewController ()

@end

@implementation BDBWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    [self.webView loadRequest:self.request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
