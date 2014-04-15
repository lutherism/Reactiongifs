//
//  GifDetailViewController.h
//  Reactiongifs
//
//  Created by Alexander Jansen on 4/13/14.
//  Copyright (c) 2014 AlexJansen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GifManagerDelegate.h"

@interface GifDetailViewController : UITableViewController <UISplitViewControllerDelegate, UITableViewDelegate, UITableViewDataSource, GifManagerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
