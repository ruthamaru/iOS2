//
//  NSDictionary+Cards.m
//  CuriyoApp
//
//  Created by Ruth Amaru on 5/21/14.
//  Copyright (c) 2014 Curiyo. All rights reserved.
//

#import "NSDictionary+Cards.h"

#define kCardWidth 304

@implementation NSDictionary (Cards)

-(NSString*)title
{
    return self[@"title"];
}

-(NSString*)ds
{
    return self[@"ds"];
}

-(NSString*)content
{
    return self[@"content"];
}

-(NSString*)contentOrig
{
    return self[@"contentOrig"];
}

-(NSString*)likes
{
    return self[@"likes"];
}

-(NSString*)dislikes
{
    return self[@"dislikes"];
}

-(NSString*)imagesUrl1
{
    return self[@"url1"];
}

-(NSString*)imagesUrl2
{
    return self[@"url2"];    
}

-(NSString*)refererclickurl1
{
    return self[@"refererclickurl1"];
}

-(NSString*)imageThumbnail1
{
    return self[@"thumbnailUrl1"];
}

-(CGSize)thumbnail1Size
{
    NSString* h1 = self[@"thumbnailHeight1"];
    NSString* w1 = self[@"thumbnailWidth1"];
    NSString* w2 = self[@"thumbnailWidth2"];

    float shrink = ([w1 floatValue] + [w2 floatValue]) / kCardWidth;
    
    CGSize size = CGSizeMake([w1 floatValue] / shrink, [h1 floatValue] / shrink);
    return size;
}

-(CGSize)thumbnail2Size;
{
    NSString* h2 = self[@"thumbnailHeight2"];
    NSString* w2 = self[@"thumbnailWidth2"];
    NSString* w1 = self[@"thumbnailWidth1"];

    float shrink = ([w1 floatValue] + [w2 floatValue]) / kCardWidth;
    
    CGSize size = CGSizeMake([w2 floatValue] / shrink, [h2 floatValue] / shrink);
    return size;
}


-(NSURL*)youTubeThumbnailURL
{
    NSDictionary* dict1 = self[@"youTube3"];
    NSDictionary* dict2 = dict1[@"thumbnail"];
    NSString *urlString = dict2[@"sqDefault"];
    return [[NSURL alloc] initWithString:urlString];
}

-(NSString*)youTubeTitle
{
    NSDictionary* dict1 = self[@"youTube3"];
    return dict1[@"title"];
}

-(NSString*)youTubeDescription
{
    NSDictionary* dict1 = self[@"youTube3"];
    return dict1[@"description"];
}

-(NSString*)youTubeURL
{
    NSDictionary* dict1 = self[@"youTube3"];
    NSDictionary* dict2 = dict1[@"player"];
    return dict2[@"mobile"];
}

-(NSString*)youTubeSrc
{
    return self[@"src"];
}

-(NSURL*)newsPicture
{
    NSString *urlString = self[@"picture"];
    if (!([urlString isEqual:[NSNull null]] || urlString == nil))
        return [[NSURL alloc] initWithString:urlString];
    else
        return NULL;
}

-(NSString*)newsAbstract1
{
    return self[@"abstract1"];
}

-(NSString*)newsHeadline
{
    return self[@"headline"];
}

-(NSString*)newsUrl
{
    return self[@"url"];
}

-(NSURL*)tweetImageUrl
{
    NSDictionary* dict1 = self[@"tweet"];
    NSString *urlString = dict1[@"bigImageUrl"];
    if (!([urlString isEqual:[NSNull null]] || urlString == nil))
        return [[NSURL alloc] initWithString:urlString];
    else
        return NULL;
}

-(NSString*)userName
{
    return self[@"userName"];
}

-(NSString*)twitterId
{
    return self[@"twitterID"];
}

-(NSString*)twitterUserScreenName
{
    return self[@"userScreenName"];
}

-(NSString*)text
{
    return self[@"text"];
}

-(NSString*)retweetCount
{
    NSNumber* number = self[@"retweetCount"];
    return [number stringValue];
}

-(NSString*)favoriteCount
{
    NSNumber* number = self[@"favoriteCount"];
    return [number stringValue];
}

-(NSURLRequest*)mapContent
{
    NSString *urlString = self[@"content"];
    if (!([urlString isEqual:[NSNull null]] || urlString == nil))
        return [NSURLRequest requestWithURL:[[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://%@",urlString]]];
    else
        return NULL;
}

-(NSString*)redditHeading
{
    return self[@"heading"];
}

-(NSString*)redditPermalink
{
    return self[@"permalink"];
}

-(NSString*)redditAuthor
{
    return self[@"author"];
}

-(NSString*)redditTimeAgo
{
    return self[@"timeAgo"];
}

-(NSString*)redditUpVotes
{
    NSNumber* number = self[@"upVotes"];
    return [number stringValue];
}
-(NSString*)redditDownVotes
{
    NSNumber* number = self[@"downVotes"];
    return [number stringValue];
}
-(NSString*)redditPoints
{
    NSNumber* number = self[@"points"];
    return [number stringValue];
}
-(NSString*)redditNumComments
{
    NSNumber* number = self[@"comments"];
    return [number stringValue];
}

-(NSString*)redditSelftext_html
{
    return self[@"selftext_html"];
}

-(NSString*)redditImgSrc
{
    return self[@"imgSrc"];
}

@end
