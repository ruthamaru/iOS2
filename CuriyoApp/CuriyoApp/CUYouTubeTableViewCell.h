//
//  CUYouTubeTableViewCell.h
//  CuriyoApp
//
//  Created by Ruth Amaru on 5/22/14.
//  Copyright (c) 2014 Curiyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface CUYouTubeTableViewCell : CUTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *youTubeThumnailImageView;
@property (weak, nonatomic) IBOutlet UILabel *youTubeTitle;
@property (weak, nonatomic) IBOutlet UILabel *youTubeDescription;
@property (strong) NSString* youTubeURL;
@property (weak, nonatomic) IBOutlet UIWebView *youTubeWebView;

@end
