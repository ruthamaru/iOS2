//
//  CUDetailedWebViewController.h
//  CuriyoApp
//
//  Created by Ruth Amaru on 8/7/14.
//  Copyright (c) 2014 Curiyo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CUDetailedWebViewController : UIViewController <UIWebViewDelegate>

@property(strong, nonatomic) NSString* url;

@property (weak, nonatomic) IBOutlet UIWebView *detailedWebView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
