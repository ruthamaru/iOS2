//
//  CUTrendsCollectionViewFlowLayout.h
//  CuriyoApp
//
//  Created by Ruth Amaru on 7/22/14.
//  Copyright (c) 2014 Curiyo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CUTrendsCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic) UIEdgeInsets itemInsets;
@property (nonatomic) CGSize itemSize; 
@property (nonatomic) CGFloat interItemSpacingY;
@property (nonatomic) NSInteger numberOfColumns;

@end
