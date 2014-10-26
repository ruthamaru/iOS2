//
//  CUHomeViewController.h
//  CuriyoApp
//
//  Created by Ruth Amaru on 7/16/14.
//  Copyright (c) 2014 Curiyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CUAutoCompleteView.h"

@interface CUHomeViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate, CUAutoCompleteViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property(strong, nonatomic) CUAutoCompleteView *autoCompleteView;
@end
