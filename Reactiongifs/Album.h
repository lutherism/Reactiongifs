//
//  Album.h
//  Reactiongifs
//
//  Created by Alexander Jansen on 4/13/14.
//  Copyright (c) 2014 AlexJansen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Album : NSObject

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSNumber *datetime;
@property (strong, nonatomic) NSString *cover;
@property (strong, nonatomic) NSNumber *cover_width;
@property (strong, nonatomic) NSNumber *cover_height;
@property (strong, nonatomic) NSString *account_url;
@property (strong, nonatomic) NSString *privacy;
@property (strong, nonatomic) NSString *layout;
@property (strong, nonatomic) NSNumber *views;
@property (strong, nonatomic) NSString *link;
@property (strong, nonatomic) NSNumber *images_count;
@property (strong, nonatomic) NSMutableArray *images;
@end
