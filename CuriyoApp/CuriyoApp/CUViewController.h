//
//  CUViewController.h
//  CuriyoApp
//
//  Created by Ruth Amaru on 5/21/14
//  Copyright (c) 2014 Curiyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CUAutoCompleteView.h"

@interface CUViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIWebViewDelegate,CUAutoCompleteViewDelegate>

@property(strong, nonatomic) NSString * searchString;
@property(strong, nonatomic) CUAutoCompleteView *autoCompleteView;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicationView;
@end
