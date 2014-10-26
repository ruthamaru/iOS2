//
//  CURedditTableViewCell.h
//  CuriyoApp
//
//  Created by Ruth Amaru on 8/11/14.
//  Copyright (c) 2014 Curiyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CUTableViewCell.h"

@interface CURedditTableViewCell : CUTableViewCell 

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *header;
@property (weak, nonatomic) IBOutlet UILabel *submitted;
@property (weak, nonatomic) IBOutlet UILabel *numPoints;
@property (weak, nonatomic) IBOutlet UILabel *numComments;
@end
