//
//  CUAutoCompleteView.h
//  CuriyoApp
//
//  Created by Ruth Amaru on 6/10/14.
//  Copyright (c) 2014 Curiyo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CUAutoCompleteView;

@protocol CUAutoCompleteViewDelegate <NSObject>

-(void)optionChosen:(NSString*)optionString;

@end

@interface CUAutoCompleteView : UIView

@property (nonatomic, weak) id <CUAutoCompleteViewDelegate> delegate;

- (void)loadWithOptions:(NSArray*)optionsArray;

@end
