//
//  CURedditContentTableViewCell.h
//  CuriyoApp
//
//  Created by Ruth Amaru on 10/13/14.
//  Copyright (c) 2014 Curiyo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CURedditContentTableViewCell : CUTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *submitted;
@property (weak, nonatomic) IBOutlet UILabel *numPoints;
@property (weak, nonatomic) IBOutlet UILabel *numComments;
@property (weak, nonatomic) IBOutlet UILabel *header;

@end
