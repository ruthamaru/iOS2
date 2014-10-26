//
//  NSDictionary+Trends_Package.m
//  CuriyoApp
//
//  Created by Ruth Amaru on 7/16/14.
//  Copyright (c) 2014 Curiyo. All rights reserved.
//

#import "NSDictionary+Trends_Package.h"

@implementation NSDictionary (Trends_Package)

-(NSArray*)trends
{
    return self[@"topics"];
}

@end
