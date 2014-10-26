//
//  CUTrendsCollectionViewFlowLayout.m
//  CuriyoApp
//
//  Created by Ruth Amaru on 7/22/14.
//  Copyright (c) 2014 Curiyo. All rights reserved.
//

#import "CUTrendsCollectionViewFlowLayout.h"
#define kTrendImageHeight 140.0f
#define kTrendImageWidth 106.0f

@implementation CUTrendsCollectionViewFlowLayout

- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    self.itemInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
    self.itemSize = CGSizeMake(kTrendImageWidth, kTrendImageHeight);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.interItemSpacingY = 0.0f;
    self.minimumLineSpacing = 0.0;
    //self.numberOfColumns = 2;
}


@end
