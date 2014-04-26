//
//  Gif.h
//  Reactiongifs
//
//  Created by Alexander Jansen on 4/13/14.
//  Copyright (c) 2014 AlexJansen. All rights reserved.
//
#import <Foundation/Foundation.h>



@interface Gif : NSObject
@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSNumber *datetime;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSNumber *animated;
@property (strong, nonatomic) NSNumber *width;
@property (strong, nonatomic) NSNumber *height;
@property (strong, nonatomic) NSNumber *size;
@property (strong, nonatomic) NSNumber *views;
@property (strong, nonatomic) NSNumber *bandwidth;
@property (strong, nonatomic) NSString *section;
@property (strong, nonatomic) NSString *link;

-(NSString *)getLink;

@end
