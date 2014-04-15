//
//  GifDetailViewController.m
//  Reactiongifs
//
//  Created by Alexander Jansen on 4/13/14.
//  Copyright (c) 2014 AlexJansen. All rights reserved.
//

#import "GifDetailViewController.h"
#import "Album.h"
#import "Gif.h"
#import "GifManager.h"
#import "GifCommunicator.h"
#import "UIImageView+WebCache.h"
#import "MKInfoPanel.h"


@interface GifDetailViewController () {
    NSMutableArray *_objects;
    NSMutableArray *_images;
    GifManager *_manager;
    NSMutableArray *_imageviews;
    NSMutableArray *_imagev;
    UIImageView *customImageView;
    NSTimer *reloadtimer;
}
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (strong, nonatomic) IBOutlet UITableView *gifTable;
- (void)configureView;
@end

@implementation GifDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

-(void)flushChache{
    [SDWebImageManager.sharedManager.imageCache clearMemory];
    [SDWebImageManager.sharedManager.imageCache clearDisk];
}

- (void)startFetchingImage:(NSString *)iid
{
    NSLog(@"searching... %@",iid);
    [_manager fetchImageAtCoordinate:iid];
}

- (void)didReceiveImage:(NSArray *)images
{
    _images = [[NSMutableArray alloc]initWithArray:images];
    _imageviews = [[NSMutableArray alloc]init];
    /*int counter = 0;
    for(Gif *image in _images){
    NSString *link = [image getLink];
        UIImageView *new = [[UIImageView alloc]init];
                        [new setImageWithURL:[NSURL URLWithString:link]
                   placeholderImage:[UIImage imageNamed:@"non"] options:counter == 0 ? SDWebImageRefreshCached : 0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                       NSIndexPath *indexPath = [NSIndexPath indexPathForRow:counter inSection:0];
                       NSArray *indexPaths = [[NSArray alloc] initWithObjects:indexPath, nil];
                       NSLog(@"Loaded image #%i",counter);
                       [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
                   }];
        counter++;
    }*/
    [_gifTable reloadData];
}

- (void)fetchingImageFailedWithError:(NSError *)error
{
    NSLog(@"Error %@; %@", error, [error localizedDescription]);
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        Album *a = _detailItem;
        self.detailDescriptionLabel.text = a.title;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _images = [[NSMutableArray alloc]init];
    _manager = [[GifManager alloc] init];
    _manager.communicator = [[GifCommunicator alloc] init];
    _manager.communicator.delegate = _manager;
    _manager.delegate = self;
    if (self.detailItem) {
        NSLog(@"image");
        Album *a = _detailItem;
        [self startFetchingImage:a.id];
    }
    [SDWebImageManager.sharedManager.imageDownloader setValue:@"SDWebImage Demo" forHTTPHeaderField:@"AppName"];
    SDWebImageManager.sharedManager.imageDownloader.executionOrder = SDWebImageDownloaderLIFOExecutionOrder;
    [self configureView];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:
								[self methodSignatureForSelector: @selector(timerCallback)]];
    [invocation setTarget:self];
    [invocation setSelector:@selector(timerCallback)];
    reloadtimer = [NSTimer scheduledTimerWithTimeInterval:3.0
										 invocation:invocation repeats:YES];

}


-(void)timerCallback{
    NSLog(@"timer");
    [_gifTable reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"making table with %lu cells", (unsigned long)[_images count]);
    return [_images count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:@"Cell"];
    }
    Gif *image = [_images objectAtIndex:indexPath.row];
    //[cell textLabel].text=image.title;
        NSString *link = [image getLink];
        [cell.imageView setImageWithURL:[NSURL URLWithString:link]
                       placeholderImage:[UIImage alloc]];
    [cell layoutSubviews];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:
(NSIndexPath *)indexPath {
    Gif *image = [_images objectAtIndex:indexPath.row];
    double height;
    height = ([image.height doubleValue] * (320/[image.width doubleValue]));
    return height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Gif *image = [_images objectAtIndex:indexPath.row];
    NSString *copyStringverse = image.link;
    UIPasteboard *pb = [UIPasteboard generalPasteboard];
    [pb setString:copyStringverse];
    [MKInfoPanel showPanelInView:self.navigationController.view
                            type:MKInfoPanelTypeInfo
                           title:@"Copied Gif Link"
                        subtitle:copyStringverse
                       hideAfter:2];
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
