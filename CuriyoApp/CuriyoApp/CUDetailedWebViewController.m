//
//  CUDetailedWebViewController.m
//  CuriyoApp
//
//  Created by Ruth Amaru on 8/7/14.
//  Copyright (c) 2014 Curiyo. All rights reserved.
//

#import "CUDetailedWebViewController.h"

@interface CUDetailedWebViewController ()

@end

@implementation CUDetailedWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"curiyo_logo"]];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    NSURL *url = [NSURL URLWithString:self.url];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    self.detailedWebView.delegate = self;
    [self.activityIndicator setHidesWhenStopped:TRUE];
    [self.activityIndicator setHidden:FALSE];
    [self.activityIndicator startAnimating];
    [self.detailedWebView loadRequest:requestObj];
    // Do any additional setup after loading the view.
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicator stopAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
