//
//  CUMapTableViewCell.h
//  CuriyoApp
//
//  Created by Ruth Amaru on 6/2/14.
//  Copyright (c) 2014 Curiyo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CUMapTableViewCell : CUTableViewCell <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *mapWebView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
