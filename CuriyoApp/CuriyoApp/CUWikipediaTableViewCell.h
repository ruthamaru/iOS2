//
//  CUWikipediaTableViewCell.h
//  CuriyoApp
//
//  Created by Ruth Amaru on 5/22/14.
//  Copyright (c) 2014 Curiyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CUTableViewCell.h"

@interface CUWikipediaTableViewCell : CUTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
