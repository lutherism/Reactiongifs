//
//  GifCommunicator.m
//  Reactiongifs
//
//  Created by Alexander Jansen on 4/13/14.
//  Copyright (c) 2014 AlexJansen. All rights reserved.
//

#import "GifCommunicator.h"

#import "GifCommunicatorDelegate.h"

#define API_KEY @"Client-ID 6c37622476b6443"
#define PAGE_COUNT 20



@implementation GifCommunicator

- (void)searchAlbumsAtCoordinate:(NSString *)coordinate
{
    NSString *urlAsString = [NSString stringWithFormat:@"https://api.imgur.com/3/account/%@/albums", coordinate];
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    NSLog(@"%@", urlAsString);
    NSMutableURLRequest *req =[[NSMutableURLRequest alloc] initWithURL:url];
    [req setValue:API_KEY forHTTPHeaderField:@"Authorization"];
    [NSURLConnection sendAsynchronousRequest:req queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            [self.delegate fetchingAlbumsFailedWithError:error];
        } else {
            [self.delegate receivedAlbumsJSON:data];
        }
    }];
}

- (void)searchGalleryAtCoordinate:(NSString *)coordinate
{
    NSString *urlAsString = [NSString stringWithFormat:@"https://api.imgur.com/3/r/%@/reactiongifs/top/1", coordinate];
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    NSLog(@"%@", urlAsString);
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            [self.delegate fetchingGalleryFailedWithError:error];
        } else {
            [self.delegate receivedGalleryJSON:data];
        }
    }];
}

- (void)searchImageAtCoordinate:(NSString *)coordinate
{
    NSString *urlAsString = [NSString stringWithFormat:@"https://api.imgur.com/3/album/%@", coordinate];
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    NSLog(@"%@", urlAsString);
    NSMutableURLRequest *req =[[NSMutableURLRequest alloc] initWithURL:url];
    [req setValue:API_KEY forHTTPHeaderField:@"Authorization"];
    [NSURLConnection sendAsynchronousRequest:req queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            [self.delegate fetchingImageFailedWithError:error];
        } else {
            [self.delegate receivedImageJSON:data];
        }
    }];
}

@end
