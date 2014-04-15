//
//  GifManagerDelegate.h
//  Reactiongifs
//
//  Created by Alexander Jansen on 4/13/14.
//  Copyright (c) 2014 AlexJansen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GifManagerDelegate
- (void)didReceiveAlbums:(NSArray *)albums;
- (void)fetchingAlbumsFailedWithError:(NSError *)error;
- (void)didReceiveGallery:(NSArray *)gallery;
- (void)fetchingGalleryFailedWithError:(NSError *)error;
- (void)didReceiveImage:(NSArray *)images;
- (void)fetchingImageFailedWithError:(NSError *)error;
@end

