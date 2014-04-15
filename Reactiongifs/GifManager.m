//
//  GifManager.m
//  Reactiongifs
//
//  Created by Alexander Jansen on 4/13/14.
//  Copyright (c) 2014 AlexJansen. All rights reserved.
//

#import "GifBuilder.h"
#import "GifCommunicator.h"
#import "GifManager.h"

@implementation GifManager
- (void)fetchAlbumsAtCoordinate:(NSString *)coordinate
{
    [self.communicator searchAlbumsAtCoordinate:coordinate];
}
- (void)fetchGalleryAtCoordinate:(NSString *)coordinate
{
    [self.communicator searchGalleryAtCoordinate:coordinate];
}- (void)fetchImageAtCoordinate:(NSString *)coordinate
{
    NSLog(@"Managing image search %@",coordinate);
    [self.communicator searchImageAtCoordinate:coordinate];
}
#pragma mark - MeetupCommunicatorDelegate

- (void)receivedAlbumsJSON:(NSData *)objectNotation
{
    NSError *error = nil;
    NSArray *groups = [GifBuilder albumsFromJSON:objectNotation error:&error];
    
    if (error != nil) {
        [self.delegate fetchingAlbumsFailedWithError:error];
        
    } else {
        [self.delegate didReceiveAlbums:groups];
    }
}

- (void)fetchingAlbumsFailedWithError:(NSError *)error
{
    [self.delegate fetchingAlbumsFailedWithError:error];
}

- (void)receivedGalleryJSON:(NSData *)objectNotation
{
    NSError *error = nil;
    NSArray *groups = [GifBuilder galleryFromJSON:objectNotation error:&error];
    
    if (error != nil) {
        [self.delegate fetchingGalleryFailedWithError:error];
        
    } else {
        [self.delegate didReceiveGallery:groups];
    }
}

- (void)fetchingGalleryFailedWithError:(NSError *)error
{
    [self.delegate fetchingGalleryFailedWithError:error];
}
- (void)receivedImageJSON:(NSData *)objectNotation
{
    NSError *error = nil;
    NSArray *groups = [GifBuilder imageFromJSON:objectNotation error:&error];
    NSLog(@"Built %i images from api",[groups count]);
    if (error != nil) {
        [self.delegate fetchingImageFailedWithError:error];
        
    } else {
        [self.delegate didReceiveImage:groups];
    }
}

- (void)fetchingImageFailedWithError:(NSError *)error
{
    [self.delegate fetchingImageFailedWithError:error];
}
@end