//
//  CUHomeViewController.m
//  CuriyoApp
//
//  Created by Ruth Amaru on 7/16/14.
//  Copyright (c) 2014 Curiyo. All rights reserved.
//

#import "CUHomeViewController.h"
#import "CUViewController.h"
#import "NSDictionary+Trends_Package.h"
#import "NSDictionary+Trends.h"
#import "CUTrendCollectionViewCell.h"
#import "UIKit+AFNetworking.h"
#import "CUHistoryTableViewCell.h"

#define kTrendImageHeight @"140"
#define kTrendImageWidth @"106"

@interface CUHomeViewController ()
@property(strong) NSDictionary *responseDictionary;
@property(strong) NSArray *trendsArray;
@property(strong) NSArray *historyArray;
@property (strong) NSMutableArray* historyImageUrlsArray;
@property(strong) NSString *searchString;

@end

@implementation CUHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"search_bar.png"] forState:UIControlStateNormal];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self startTrendsRetrieval];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"curiyo_logo"]];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

    [self.pageControl addTarget:self
                           action:@selector(scrollTrend:)
                 forControlEvents:UIControlEventValueChanged];

    [self.autoCompleteView setHidden:TRUE];
    self.autoCompleteView = [[CUAutoCompleteView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.autoCompleteView.delegate = self;
    [self.view addSubview:self.autoCompleteView];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection view

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.trendsArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *trendDictionary = [self.trendsArray objectAtIndex:indexPath.row];

    CUTrendCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"trendCellID" forIndexPath:indexPath];
    
    // make the cell's title the actual NSIndexPath value
    cell.trendLabel.text = [trendDictionary topic];
    cell.trendImage.contentMode = UIViewContentModeScaleToFill;
    [cell.trendImage setImageWithURL:[trendDictionary imgSrc1]];
    
    self.pageControl.currentPage = indexPath.row;
    return cell;
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath 
{

    NSDictionary *trendDictionary = [self.trendsArray objectAtIndex:indexPath.row];
    self.searchString = [trendDictionary topic];
    [self performSegueWithIdentifier:@"openCardsFromHome" sender:self];
    NSLog(@"selected: %@", self.searchString);
}

#pragma mark - Table View

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.historyArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"HistoryArray"];
    self.historyImageUrlsArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"HistoryImageUrlsArray"];

    return [self.historyArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HistoryCell";
    CUHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.historyTermLabel.text = [[self.historyArray objectAtIndex:indexPath.row] stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
    NSLog(@"imageurl:%@",[self.historyImageUrlsArray objectAtIndex:indexPath.row]);
    [cell.historyImage setImageWithURL:[NSURL URLWithString:[self.historyImageUrlsArray objectAtIndex:indexPath.row]]];

    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CUHistoryTableViewCell* cell = (CUHistoryTableViewCell*) [self.tableView cellForRowAtIndexPath:indexPath];
    self.searchString = cell.historyTermLabel.text;
    [self performSegueWithIdentifier:@"openCardsFromHome" sender:self];
    NSLog(@"selected: %@", self.searchString);
}


-(IBAction)scrollTrend:(id)sender
{
    //TO DO - implement
}

#pragma Data

-(void)startTrendsRetrieval
{
    NSString *string = [NSString stringWithFormat:@"http://staging.curiyo.com/trending3?lang=en&locale=en-us&width=%@&height=%@&count=10",kTrendImageWidth, kTrendImageHeight];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [self.activityIndicationView stopAnimating];
        self.responseDictionary = (NSDictionary *)responseObject;
        NSLog(@"%@",responseObject);
        self.trendsArray = [self.responseDictionary trends];
        self.pageControl.numberOfPages = [self.trendsArray count];
//        [self.tableView setHidden:FALSE];
        [self.collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        [self.activityIndicationView stopAnimating];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Cards"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
//    [self.activityIndicationView setHidden:false];
//    [self.activityIndicationView startAnimating];
    [operation start];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    self.searchString = searchBar.text;
    [self performSegueWithIdentifier:@"openCardsFromHome" sender:self];
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
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    NSString *searchString = [optionString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    [self.autoCompleteView setHidden:TRUE];
    self.searchString = searchString;
    [self performSegueWithIdentifier:@"openCardsFromHome" sender:self];

}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"openCardsFromHome"]) {
        CUViewController *vc = [segue destinationViewController];
        vc.searchString = self.searchString;
        NSLog(@"In Segue setting searchstring to %@", self.searchString);
    }
}

@end
