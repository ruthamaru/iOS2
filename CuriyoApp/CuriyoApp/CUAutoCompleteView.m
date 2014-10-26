//
//  CUAutoCompleteView.m
//  CuriyoApp
//
//  Created by Ruth Amaru on 6/10/14.
//  Copyright (c) 2014 Curiyo. All rights reserved.
//

#import "CUAutoCompleteView.h"
#import <QuartzCore/QuartzCore.h>

@implementation CUAutoCompleteView

- (void)loadWithOptions:(NSArray*)optionsArray
{
//    CGFloat height= [optionsArray count] * 22;
    [self setFrame:CGRectMake(0, 100, 320, 253)];
    self.layer.cornerRadius = 5;
    self.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.layer.masksToBounds = YES;
    for (NSInteger i=0; i< [optionsArray count]; i++) {
        UIButton *button = (UIButton*)[self viewWithTag:i+100];
        [button setTitle:optionsArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [button setContentEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
        [button addTarget:self action:@selector(selectOption:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)selectOption:(id)sender
{
    UIButton* button = (UIButton*) sender;
    [self.delegate optionChosen:button.titleLabel.text];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        for (NSInteger i=0; i< 8; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            [button setTag:i+100];
            [button setFrame:CGRectMake(8, i*22, 304, 22)];
            [self addSubview:button];
        }
    }
    return self;
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
