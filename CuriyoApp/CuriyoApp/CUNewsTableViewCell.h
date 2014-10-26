//
//  CUNewsTableViewCell.h
//  CuriyoApp
//
//  Created by Ruth Amaru on 5/29/14.
//  Copyright (c) 2014 Curiyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CUTableViewCell.h"

@interface CUNewsTableViewCell : CUTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;
@property (weak, nonatomic) IBOutlet UILabel *headlineLabel;
@property (weak, nonatomic) IBOutlet UILabel *abstractLabel;
@end
