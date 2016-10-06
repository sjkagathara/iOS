//
//  ViewController.m
//  sampleCode
//
//  Created by Kalpesh Parikh on 10/5/16.
//  Copyright © 2016 kalpesh parikh. All rights reserved.
//

#import "APIViewController.h"
#import "ViewController.h"
#import "CustomCell.h"
#import "IconDownloader.h"


#define APIURL @"https://itunes.apple.com"
#define SEARCH @"/search/"
#define TABLE_CELL_HEIGHT 75.0f


@interface APIViewController () <UIScrollViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UISearchBar *searchbar;
@property (nonatomic, strong) NSMutableArray *loadedChatData;
@property (nonatomic, strong) NSMutableDictionary *imageDownloadsInProgress;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@end

@implementation APIViewController
NSTimeInterval executionTime;

- (void)viewDidLoad
{
    [super viewDidLoad];
    _imageDownloadsInProgress = [NSMutableDictionary dictionary];
    self.loadedChatData = [[NSMutableArray alloc] init];
    // giving title to navigation bar
    self.title=@"Search API";
    // setting properties to tablview in order to work with dynamic height of cell using auto layout
    self.tableView.estimatedRowHeight = 65.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // call to loadJSONData in order to load json data to local data structure like array
    //[self loadJSONData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar // called when cancel button pressed
{
    [self.loadedChatData removeAllObjects];
    [_tableView reloadData];
}



// called when keyboard search button pressed
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    if(searchBar.text.length == 0)
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Input Validation"
                                                                       message:@"Please enter search term"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        _activityView = [[UIActivityIndicatorView alloc]
                         initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        _activityView.center=self.view.center;
        [_activityView startAnimating];
        [self.view addSubview:_activityView];
        [self callSearchAPI];
    }
    
}



-(void)callSearchAPI
{
    NSDate *methodStart = [NSDate date];
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APIURL,SEARCH]];
    NSString *post = [NSString stringWithFormat:@"term=%@&entity=musicVideo",[_searchbar.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:URL];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              [_activityView stopAnimating];
                                              [_activityView removeFromSuperview];
                                              NSDate *methodFinish = [NSDate date];
                                              executionTime = [methodFinish timeIntervalSinceDate:methodStart];
                                          });
                                          if(!error)
                                          {
                                              NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data
                                                                                                       options:kNilOptions
                                                                                                         error:&error];
                                              if(jsonDict != nil)
                                              {
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      NSString *strMessage = [NSString stringWithFormat:@"\nAPI took %f miliseconds",executionTime];
                                                      UIAlertController* alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@ Records Found",[jsonDict valueForKey:@"resultCount"]]
                                                                                                                     message:strMessage
                                                                                                              preferredStyle:UIAlertControllerStyleAlert];
                                                      UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                                                            handler:^(UIAlertAction * action) {
                                                                                                                if([jsonDict valueForKey:@"resultCount"] == 0)
                                                                                                                {
                                                                                                                    [_searchbar becomeFirstResponder];
                                                                                                                }
                                                                                                                else if([jsonDict valueForKey:@"resultCount"] > 0)
                                                                                                                {
                                                                                                                    [self displayResult: jsonDict];
                                                                                                                }
                                                                                                            }];
                                                      [alert addAction:defaultAction];
                                                      [self presentViewController:alert animated:YES completion:nil];
                                                  });
                                              }
                                              else
                                              {
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      NSString *strMessage = [NSString stringWithFormat:@"Invalid URL\n API took %f miliseconds",executionTime];
                                                      UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                                                     message:strMessage
                                                                                                              preferredStyle:UIAlertControllerStyleAlert];
                                                      UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                                                            handler:^(UIAlertAction * action) {}];
                                                      [alert addAction:defaultAction];
                                                      [self presentViewController:alert animated:YES completion:nil];
                                                  });
                                              }
                                          }
                                          else
                                          {
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  NSString *strMessage = [NSString stringWithFormat:@"%@\n API took %f miliseconds",error.localizedDescription,executionTime];
                                                  UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                                                 message:strMessage
                                                                                                          preferredStyle:UIAlertControllerStyleAlert];
                                                  UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                                                        handler:^(UIAlertAction * action) {}];
                                                  [alert addAction:defaultAction];
                                                  [self presentViewController:alert animated:YES completion:nil];
                                              });
                                          }
                                      }];
    [dataTask resume];
}

#pragma textfield delegate method



// custom method to load json data to array
- (void)displayResult: (NSDictionary *) JSONData
{
    [self.loadedChatData removeAllObjects];
    if ([JSONData isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *jsonDict = (NSDictionary *)JSONData;
        NSArray *loadedArray = [jsonDict objectForKey:@"results"];
        if ([loadedArray isKindOfClass:[NSArray class]])
        {
            for (NSDictionary *chatDict in loadedArray)
            {
                CellData *cellData = [[CellData alloc] init];
                [cellData loadWithDictionary:chatDict];
                [self.loadedChatData addObject:cellData];
            }
        }
    }
    [self.tableView reloadData];
}


#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CustomCell";
    CustomCell *cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = (CustomCell *)[nib objectAtIndex:0];
    }
    CellData *cellData = [self.loadedChatData objectAtIndex:[indexPath row]];
    [cell loadWithData:cellData];
    if (!cellData.appIcon)
    {
        if (self.tableView.dragging == NO && self.tableView.decelerating == NO)
        {
            [self startIconDownload:cellData forIndexPath:indexPath];
        }
        // if a download is deferred or in progress, return a placeholder image
        [cell loadWithImage:[UIImage imageNamed:@"Placeholder.png"]];
    }
    else
    {
        [cell loadWithImage:cellData.appIcon];
        
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.loadedChatData.count;
}


#pragma mark - Table cell image support

//	method startIconDownload to download images (icons)
- (void)startIconDownload:(CellData *)appRecord forIndexPath:(NSIndexPath *)indexPath
{
    IconDownloader *iconDownloader = (self.imageDownloadsInProgress)[indexPath];
    if (iconDownloader == nil)
    {
        iconDownloader = [[IconDownloader alloc] init];
        iconDownloader.appRecord = appRecord;
        [iconDownloader setCompletionHandler:^{
            CustomCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            // Display the newly loaded image
            [cell loadWithImage:appRecord.appIcon];
            // Remove the IconDownloader from the in progress list.
            // This will result in it being deallocated.
            [self.imageDownloadsInProgress removeObjectForKey:indexPath];
        }];
        (self.imageDownloadsInProgress)[indexPath] = iconDownloader;
        [iconDownloader startDownload];
    }
}

// method to terminate downloading images (icon)
- (void)terminateAllDownloads
{
    // terminate all pending download connections
    NSArray *allDownloads = [self.imageDownloadsInProgress allValues];
    [allDownloads makeObjectsPerformSelector:@selector(cancelDownload)];
    
    [self.imageDownloadsInProgress removeAllObjects];
}

//  loadImagesForOnscreenRows method is used in case the user scrolled into a set of cells that don't
//  have their app icons yet.
- (void)loadImagesForOnscreenRows
{
    if (self.loadedChatData.count > 0)
    {
        NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths)
        {
            CellData *appRecord = (self.loadedChatData)[indexPath.row];
            if (!appRecord.appIcon)
            // Avoid the app icon download if the app already has an icon
            {
                [self startIconDownload:appRecord forIndexPath:indexPath];
            }
        }
    }
}


#pragma mark - UIScrollViewDelegate


//  Load images for all onscreen rows when scrolling is finished.
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        [self loadImagesForOnscreenRows];
    }
}

//  When scrolling stops, proceed to load the app icons that are on screen.
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnscreenRows];
}


#pragma clean up

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self terminateAllDownloads];
    
}



@end

