//
//  BDBWebViewController.h
//  TravelAppTests
//
//  Created by Bruno Domínguez on 05/03/15.
//  Copyright (c) 2015 brunodominguez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDBWebViewController : UIViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic)NSURLRequest *request;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;

@end
