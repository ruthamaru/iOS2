//
//  CUViewController.m
//  CuriyoApp
//
//  Created by Ruth Amaru on 5/21/14.
//  Copyright (c) 2014 Curiyo. All rights reserved.
//

#import "CUViewController.h"
#import "NSDictionary+Cards.h"
#import "NSDictionary+Cards_Package.h"
#import "CUWikipediaTableViewCell.h"
#import "CUImagesTableViewCell.h"
#import "CUYouTubeTableViewCell.h"
#import "CUNewsTableViewCell.h"
#import "UIKit+AFNetworking.h"
#import "CUTweetsTableViewCell.h"
#import "CUMapTableViewCell.h"
#import "CUDetailedWebViewController.h"
#import "CURedditTableViewCell.h"
#import "CURedditContentTableViewCell.h"
#import "NSString+stripHTML.h"

#define kHeaderHeight 35
#define kCardPadding 8
#define kCardWidth 304
#define kMaxHistory 10
#define kTwitterURL @"https://twitter.com/%@/statuses/%@"

@interface CUViewController ()
@property(strong) NSDictionary *responseDictionary;
@property(strong) NSArray *cardsArray;
@property (strong) NSMutableArray* historyArray;
@property (strong) NSMutableArray* historyImageUrlsArray;
@property(nonatomic) BOOL completedNewImageRequest;
@property (strong, nonatomic) NSString* detailedUrlForSegue;

@end

@implementation CUViewController

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"search_bar.png"] forState:UIControlStateNormal];
    UIImage *backButtonImage = [[UIImage imageNamed:@"back_arrow.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 26, 0, 0)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"curiyo_logo"]];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    [self.tableView setHidden:TRUE];
    [self.activityIndicationView setHidesWhenStopped:TRUE];
    [self.activityIndicationView setHidden:TRUE];

    [self.autoCompleteView setHidden:TRUE];
    self.autoCompleteView = [[CUAutoCompleteView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.autoCompleteView.delegate = self;
    [self.view addSubview:self.autoCompleteView];
    
    self.completedNewImageRequest = FALSE;
    
    if ([self.searchString length] > 0)
    {
        [self showCards:self.searchString];
        [self.searchBar setText:[self.searchString stringByReplacingOccurrencesOfString:@"%20" withString:@" "]];
    }

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!self.responseDictionary)
        return 0;
    else
        return [self.cardsArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cardDictionary = [self.cardsArray objectAtIndex:indexPath.row];
    NSString* cardTitle = [cardDictionary title];
    
    if ([cardTitle isEqualToString:@"Wikipedia"])
    {
        return 210.0;
    }
    else if ([cardTitle isEqualToString:@"Images"])
    {
        return 417.0;
    }
    else if ([cardTitle isEqualToString:@"YouTube"])
    {
        return 260.0;
    }
    else if ([cardTitle isEqualToString:@"News"])
    {
        return 194.0;
    }
    else if ([cardTitle isEqualToString:@"Tweets"])
    {
        return 207.0;
    }
    else if ([cardTitle isEqualToString:@"Map"])
    {
        return 233.0;
    }
    else if ([cardTitle isEqualToString:@"reddit"])
    {
        NSString* imageString = [cardDictionary redditImgSrc];
        NSString* contentString = [cardDictionary redditSelftext_html];
        if (!([imageString isEqual:[NSNull null]] || imageString == nil)) {
            return 572.0;
        }
        else if (!([contentString isEqual:[NSNull null]] || contentString == nil)) {
            return 223.0;
        }
        else
        return 0;
    }
    else
    {
        return 0.0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cardDictionary = [self.cardsArray objectAtIndex:indexPath.row];
    NSString* cardTitle = [cardDictionary title];

    if ([cardTitle isEqualToString:@"Wikipedia"])
    {
        static NSString *CellIdentifier = @"WikipediaCardCell";
        CUWikipediaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.titleLabel.text = cardTitle;
        cell.contentLabel.text = [cardDictionary content];
        cell.detailsUrlString = [cardDictionary contentOrig];
        return cell;
    }
    else if ([cardTitle isEqualToString:@"Images"])
    {
        static NSString *CellIdentifier = @"ImagesCardCell";
        CUImagesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.titleLabel.text = cardTitle;
        [cell.image1 setImageWithURL:[NSURL URLWithString:[cardDictionary imagesUrl1]]];
        cell.detailsUrlString = [cardDictionary refererclickurl1];
        return cell;
    }
    else if ([cardTitle isEqualToString:@"YouTube"])
    {
        static NSString *CellIdentifier = @"YouTubeCardCell";
        CUYouTubeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.titleLabel.text = cardTitle;
        [cell.youTubeThumnailImageView setImageWithURL:[cardDictionary youTubeThumbnailURL]];
        cell.youTubeTitle.text = [cardDictionary youTubeTitle];
        cell.youTubeDescription.text = [cardDictionary youTubeDescription];
        cell.youTubeURL = [cardDictionary youTubeURL];
        cell.detailsUrlString = [cardDictionary youTubeURL];
        NSString *html = [NSString stringWithFormat:@"<html><body><iframe class=\"youtube-player\" type=\"text/html\" width=\"%f\" height=\"%f\" src=\"http://www.youtube.com/embed/%@?HD=1;rel=0;showinfo=0\" allowfullscreen frameborder=\"0\" rel=nofollow></iframe></body></html>",cell.youTubeWebView.frame.size.width,cell.youTubeWebView.frame.size.height, [cardDictionary youTubeSrc]];
        [cell.youTubeWebView loadHTMLString:html baseURL:nil];
        
        
        return cell;
    }
    else if ([cardTitle isEqualToString:@"News"])
    {
        static NSString *CellIdentifier = @"NewsCardCell";
        CUNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.titleLabel.text = cardTitle;
        cell.headlineLabel.text = [cardDictionary newsHeadline];
        cell.abstractLabel.text = [cardDictionary newsAbstract1];
        cell.detailsUrlString = [cardDictionary newsUrl];

        return cell;
    }
    else if ([cardTitle isEqualToString:@"Tweets"])
    {
        static NSString *CellIdentifier = @"TweetsCardCell";
        CUTweetsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.titleLabel.text = cardTitle;
        [cell.avatarImageView setImageWithURL:[cardDictionary tweetImageUrl]];
        cell.userNameLabel.text = [cardDictionary userName];
        cell.tweetLabel.text = [cardDictionary text];
        cell.retweetsLabel.text = [cardDictionary retweetCount];
        cell.favoritesLabel.text = [cardDictionary favoriteCount];
        cell.detailsUrlString = [NSString stringWithFormat:kTwitterURL, [cardDictionary twitterUserScreenName], [cardDictionary twitterId]];
        return cell;
    }
    else if ([cardTitle isEqualToString:@"Map"])
    {
        static NSString *CellIdentifier = @"MapCardCell";
        CUMapTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.titleLabel.text = cardTitle;
        cell.mapWebView.delegate = self;
        cell.detailsUrlString = [cardDictionary contentOrig];
        [cell.mapWebView loadRequest:[cardDictionary mapContent]];

        return cell;
    }
    else if ([cardTitle isEqualToString:@"reddit"])
    {

        NSString* imageString = [cardDictionary redditImgSrc];
        NSString* contentString = [cardDictionary redditSelftext_html];
        if (!([imageString isEqual:[NSNull null]] || imageString == nil)) {
            static NSString *CellIdentifier = @"RedditCardCell";
            CURedditTableViewCell *cell = (CURedditTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            cell.titleLabel.text = cardTitle;
            [cell.image setImageWithURL:[NSURL URLWithString:[cardDictionary redditImgSrc]]];
            
            cell.header.text = [cardDictionary redditHeading];
            cell.submitted.text = [cardDictionary redditTimeAgo];
            cell.numPoints.text = [cardDictionary redditPoints];
            cell.numComments.text = [cardDictionary redditNumComments];
            cell.detailsUrlString = [cardDictionary redditPermalink];
            return cell;
        }
        else if (!([contentString isEqual:[NSNull null]] || contentString == nil)) {
            static NSString *CellIdentifier = @"RedditContentCardCell";
            CURedditContentTableViewCell *cell = (CURedditContentTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            cell.titleLabel.text = cardTitle;
            cell.header.text = [cardDictionary redditHeading];
            cell.contentLabel.text = [[cardDictionary redditSelftext_html] stripHtml];
            cell.submitted.text = [cardDictionary redditTimeAgo];
            cell.numPoints.text = [cardDictionary redditPoints];
            cell.numComments.text = [cardDictionary redditNumComments];
            cell.detailsUrlString = [cardDictionary redditPermalink];
            return cell;
        }
        else {
            static NSString *CellIdentifier = @"CardCell";
            UITableViewCell *cell = (CURedditTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            //            cell.titleLabel.text = cardTitle;
            //            [cell.image setImageWithURL:[NSURL URLWithString:[cardDictionary redditImgSrc]]];
            //
            //            cell.header.text = [cardDictionary redditHeading];
            //            cell.submitted.text = [cardDictionary redditTimeAgo];
            //            cell.numPoints.text = [cardDictionary redditPoints];
            //            cell.numComments.text = [cardDictionary redditNumComments];
            return cell;
        }
        
        

    }
    
    else
    {
        static NSString *CellIdentifier = @"CardCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        [cell setHidden:TRUE];
        //cell.textLabel.text = cardTitle;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    CUTableViewCell *cell = (CUTableViewCell*) [tableView cellForRowAtIndexPath:indexPath];
    self.detailedUrlForSegue = cell.detailsUrlString;
    [self performSegueWithIdentifier:@"pushDetailedWebView" sender:self];
    
    
//    if ([cell.reuseIdentifier isEqualToString:@"YouTubeCardCell"]) {
//        CUYouTubeTableViewCell *youTubeCell = (CUYouTubeTableViewCell*) cell;
//        NSLog(@"Youtube Selected:%@", youTubeCell.youTubeURL);
//        [[UIApplication sharedApplication]
//         openURL:[[NSURL alloc] initWithString: youTubeCell.youTubeURL]];
//    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%@",error);
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self.tableView setHidden:TRUE];
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    [self showCards:searchBar.text];
}

-(void)showCards:(NSString *)searchString
{
    
    NSString* urlSearchString = [searchString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];

    NSString *string = [NSString stringWithFormat:@"http://curiyo.com/lookup?q=%@&cards=1&json=1&cardsearch=true&androidApp=true&lookup=stage1_plus_twitter", urlSearchString];
    //call news_web_images after and then this again
    NSLog(@"%@",string);
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.activityIndicationView stopAnimating];
        self.responseDictionary = (NSDictionary *)responseObject;
        self.cardsArray = [self.responseDictionary cards];
        [self.tableView setHidden:FALSE];
        [self.tableView reloadData];
        [self addToHistoryArray:searchString];
        if (self.sendNewsImagesRequest)
            [self startImageRetrieval:urlSearchString];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self.activityIndicationView setHidden:FALSE];
        [self.activityIndicationView stopAnimating];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Cards"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    [self.activityIndicationView setHidden:false];
    [self.activityIndicationView startAnimating];
    [operation start];
}

-(BOOL)sendNewsImagesRequest
{
    if (self.completedNewImageRequest)
        return FALSE;
    if ([self.responseDictionary needsNewsImages])
        return TRUE;
    else
        return FALSE;
    
}

-(void)startImageRetrieval:(NSString *)searchString
{
    NSString *string = [NSString stringWithFormat:@"http://curiyo.com/lookup?q=%@&cards=1&json=1&cardsearch=true&androidApp=true&lookup=news_web_images", searchString];
    //call news_web_images after and then this again
    NSLog(@"%@",string);
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.cardsArray = [self.responseDictionary cards];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Cards"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    [self.activityIndicationView setHidden:false];
    [self.activityIndicationView startAnimating];
    [operation start];
    
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"search text: %@",searchText);
    if (![searchText isEqual:@""])
    {
        NSString *searchTextEncoded = [searchText stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        NSString *urlString = [NSString stringWithFormat:@"http://en.wikipedia.org/w/api.php?action=opensearch&search=%@&limit=8&namespace=0&format=json", searchTextEncoded];
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSArray *array = responseObject;
            NSArray *optionsArray = array[1];
            [self.autoCompleteView setHidden:FALSE];
            [self.autoCompleteView loadWithOptions:optionsArray];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Autocomplete"
                                                                message:[error localizedDescription]
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
        }];
        [operation start];
    }
}

-(void)optionChosen:(NSString*)optionString
{
    [self.searchBar setText:optionString];
    [self.searchBar resignFirstResponder];
    [self.tableView setHidden:TRUE];
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    [self.autoCompleteView setHidden:TRUE];
    [self showCards:optionString];
 
}

-(void) addToHistoryArray:(NSString*) searchString
{
    //Add to History Array
    self.historyArray   = [[[NSUserDefaults standardUserDefaults]objectForKey:@"HistoryArray"] mutableCopy];
    self.historyImageUrlsArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"HistoryImageUrlsArray"] mutableCopy];
    if (!self.historyArray)
        self.historyArray = [[NSMutableArray alloc] initWithCapacity:(NSInteger) 10];
    if (!self.historyImageUrlsArray)
        self.historyImageUrlsArray = [[NSMutableArray alloc] initWithCapacity:(NSInteger) 10];
    
    if (![self.historyArray containsObject:[self.searchString stringByReplacingOccurrencesOfString:@"%20" withString:@" "]])
    {
        [self.historyArray insertObject:searchString atIndex:0];
        //Add a picture url to the History Images Array
        for (NSDictionary *dict in self.cardsArray)
        {
            if ([[dict title] isEqualToString:@"Images"]) {
                NSLog(@"thumbnail when I write it:%@",[dict imageThumbnail1]);
                [self.historyImageUrlsArray insertObject:[dict imageThumbnail1] atIndex:0];
                break;
            }
        }

        if ([self.historyArray count] > kMaxHistory) {
            [self.historyArray removeLastObject];
            [self.historyImageUrlsArray removeLastObject];
        }
        [[NSUserDefaults standardUserDefaults] setObject:self.historyArray forKey:@"HistoryArray"];
        [[NSUserDefaults standardUserDefaults] setObject:self.historyImageUrlsArray forKey:@"HistoryImageUrlsArray"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    //TODO if already in array move to the beginning
    
    
    NSLog(@"Show Cards: %@",self.historyArray);
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"pushDetailedWebView"]) {
        CUDetailedWebViewController*vc = [segue destinationViewController];
        vc.url = self.detailedUrlForSegue;
        NSLog(@"In Segue setting searchstring to %@", self.searchString);
    }
}


@end
