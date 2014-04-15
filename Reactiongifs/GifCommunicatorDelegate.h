//
//  GifCommuniatorDelegate.h
//  Reactiongifs
//
//  Created by Alexander Jansen on 4/13/14.
//  Copyright (c) 2014 AlexJansen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GifCommunicatorDelegate <NSObject>

- (void)receivedImageJSON:(NSData *)objectNotation;
- (void)fetchingImageFailedWithError:(NSError *)error;

- (void)receivedAlbumsJSON:(NSData *)objectNotation;
- (void)fetchingAlbumsFailedWithError:(NSError *)error;

- (void)receivedGalleryJSON:(NSData *)objectNotation;
- (void)fetchingGalleryFailedWithError:(NSError *)error;

@end
