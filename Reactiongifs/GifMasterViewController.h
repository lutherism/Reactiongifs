//
//  GifMasterViewController.h
//  Reactiongifs
//
//  Created by Alexander Jansen on 4/13/14.
//  Copyright (c) 2014 AlexJansen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GifDetailViewController;

@interface GifMasterViewController : UITableViewController

@property (strong, nonatomic) GifDetailViewController *detailViewController;

@end
