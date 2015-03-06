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


#pragma mark - LIFECYCLE

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    [self.webView loadRequest:self.request];
    [self.activity startAnimating];
    self.activity.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - WEBVIEW DELEGATE

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [self.activity stopAnimating];
    self.activity.hidden = YES;
}


@end
