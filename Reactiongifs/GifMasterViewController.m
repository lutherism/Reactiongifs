//
//  GifMasterViewController.m
//  Reactiongifs
//
//  Created by Alexander Jansen on 4/13/14.
//  Copyright (c) 2014 AlexJansen. All rights reserved.
//

#import "GifMasterViewController.h"
#import "GifDetailViewController.h"
#import "Album.h"
#import "GifManager.h"
#import "GifCommunicator.h"
#import "UIImageView+WebCache.h"

@interface GifMasterViewController () {
    NSMutableArray *_objects;
    NSArray *_albums;
    GifManager *_manager;
    NSTimer *reloadimages;
}
@end

@implementation GifMasterViewController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    /*self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
        self.navigationItem.rightBarButtonItem = addButton;
        self.detailViewController = (GifDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    */
    _manager = [[GifManager alloc] init];
    _manager.communicator = [[GifCommunicator alloc] init];
    _manager.communicator.delegate = _manager;
    _manager.delegate = self;
    /*NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:
								[self methodSignatureForSelector: @selector(timerCallback)]];
    [invocation setTarget:self];
    [invocation setSelector:@selector(timerCallback)];
    reloadimages = [NSTimer scheduledTimerWithTimeInterval:1.0
										 invocation:invocation repeats:YES];*/
    [self startFetchingAlbums];
}

-(void)timerCallback{
    NSLog(@"timer");
    [_albumTable reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startFetchingAlbums
{
    NSLog(@"searching...");
    [_manager fetchAlbumsAtCoordinate:@"reactiongifsarchive"];
}

- (void)didReceiveAlbums:(NSArray *)albums
{
    NSLog(@"got Albums");
    _albums = albums;
    [_albumTable reloadData];
    [_albumTable performSelector:@selector(reloadData) withObject:nil afterDelay:0.1];

    
}
-(void)reloadData{
    [_albumTable reloadData];
}

- (void)fetchingAlbumsFailedWithError:(NSError *)error
{
    NSLog(@"Error %@; %@", error, [error localizedDescription]);
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"building cells");
    return [_albums count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"building a cell");
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if([_albums count]>0){
    Album *album = _albums[indexPath.row];
    NSString *albumname = album.title;
    NSString *coverlink =[NSString stringWithFormat: @"http://imgur.com/%@t.gif",album.cover];
    [cell.imageView setImageWithURL:[NSURL URLWithString:coverlink]
                   placeholderImage:[UIImage imageNamed:@"placeholder.png"] options:SDWebImageProgressiveDownload];
        cell.textLabel.text = albumname;

    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        Album *album = _albums[indexPath.row];
        NSString *albumID = album.id;
        self.detailViewController.detailItem = albumID;
        NSLog(@"sent data to next view");
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Album *album = _albums[indexPath.row];
        [[segue destinationViewController] setDetailItem:album];
    }
}

@end
