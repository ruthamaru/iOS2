//
//  NSDictionary+Cards_Package.m
//  CuriyoApp
//
//  Created by Ruth Amaru on 5/21/14.
//  Copyright (c) 2014 Curiyo. All rights reserved.
//

#import "NSDictionary+Cards_Package.h"
#import "NSDictionary+Cards.h"

@implementation NSDictionary (Cards_Package)

-(NSArray*)cards
{
    return self[@"cards"];
}

-(BOOL) needsNewsImages
{
    NSArray* cards = [self cards];
    for (NSDictionary *card in cards) {
        if ([[card title] isEqualToString:@"News"]) {
            if ([[card newsPicture] isEqual:[NSNull null]] || [card newsPicture] == nil ) {
                return TRUE;
            }
        }
    }
    return FALSE;
}
@end
