//
//  CUNewsTableViewCell.m
//  CuriyoApp
//
//  Created by Ruth Amaru on 5/29/14.
//  Copyright (c) 2014 Curiyo. All rights reserved.
//

#import "CUNewsTableViewCell.h"

@implementation CUNewsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
