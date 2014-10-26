//
//  CUCardFooterView.m
//  CuriyoApp
//
//  Created by Ruth Amaru on 7/31/14.
//  Copyright (c) 2014 Curiyo. All rights reserved.
//

#import "CUCardFooterView.h"

@implementation CUCardFooterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (id)cardFooterView
{
    CUCardFooterView *cardFooterView = [[[NSBundle mainBundle] loadNibNamed:@"FooterView" owner:nil options:nil] lastObject];
    
    // make sure customView is not nil or the wrong class!
    if ([cardFooterView isKindOfClass:[CUCardFooterView class]])
        return cardFooterView;
    else
        return nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
