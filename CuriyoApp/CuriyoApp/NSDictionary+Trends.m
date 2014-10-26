//
//  NSDictionary+Trends.m
//  CuriyoApp
//
//  Created by Ruth Amaru on 7/17/14.
//  Copyright (c) 2014 Curiyo. All rights reserved.
//

#import "NSDictionary+Trends.h"

@implementation NSDictionary (Trends)

-(NSString*)topic
{
    return self[@"topic"];
}

-(NSURL*)imgSrc1
{
    NSArray *images = self[@"images"];
    NSDictionary* imgDict = images[0];
    return [NSURL URLWithString:imgDict[@"source"]];
}

@end
