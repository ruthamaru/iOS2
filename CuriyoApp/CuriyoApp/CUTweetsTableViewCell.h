//
//  CUTweetsTableViewCell.h
//  CuriyoApp
//
//  Created by Ruth Amaru on 5/29/14.
//  Copyright (c) 2014 Curiyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CUTableViewCell.h"

@interface CUTweetsTableViewCell : CUTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;

@property (weak, nonatomic) IBOutlet UILabel *retweetsLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoritesLabel;
@end
