//
//  NSDictionary+Cards.h
//  CuriyoApp
//
//  Created by Ruth Amaru on 5/21/14.
//  Copyright (c) 2014 Curiyo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Cards)

-(NSString*)title;
-(NSString*)ds;
-(NSString*)content;
-(NSString*)contentOrig;
-(NSString*)likes;
-(NSString*)dislikes;
-(NSString*)imagesUrl1;
-(NSString*)imagesUrl2;
-(NSString*)refererclickurl1;
-(CGSize)thumbnail1Size;
-(CGSize)thumbnail2Size;
-(NSString*)imageThumbnail1;
-(NSString*)youTubeTitle;
-(NSString*)youTubeDescription;
-(NSURL*)youTubeThumbnailURL;
-(NSString*)youTubeURL;
-(NSString*)youTubeSrc;
-(NSString*)newsAbstract1;
-(NSString*)newsHeadline;
-(NSURL*)newsPicture;
-(NSString*)newsUrl;
-(NSURL*)tweetImageUrl;
-(NSString*)userName;
-(NSString*)twitterId;
-(NSString*)twitterUserScreenName;
-(NSString*)text;
-(NSString*)retweetCount;
-(NSString*)favoriteCount;
-(NSURLRequest*)mapContent;
-(NSString*)redditHeading;
-(NSString*)redditPermalink;
-(NSString*)redditAuthor;
-(NSString*)redditTimeAgo;
-(NSString*)redditUpVotes;
-(NSString*)redditDownVotes;
-(NSString*)redditPoints;
-(NSString*)redditNumComments;
-(NSString*)redditSelftext_html;
-(NSString*)redditImgSrc;
@end
