//
//  GifManager.h
//  Reactiongifs
//
//  Created by Alexander Jansen on 4/13/14.
//  Copyright (c) 2014 AlexJansen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GifManagerDelegate.h"
#import "GifCommunicatorDelegate.h"

@class GifCommunicator;

@interface GifManager : NSObject<GifCommunicatorDelegate>
@property (strong, nonatomic) GifCommunicator *communicator;
@property (weak, nonatomic) id<GifManagerDelegate> delegate;

- (void)fetchAlbumsAtCoordinate:(NSString *)coordinate;
- (void)fetchGalleryAtCoordinate:(NSString *)coordinate;
- (void)fetchImageAtCoordinate:(NSString *)coordinate;
@end
