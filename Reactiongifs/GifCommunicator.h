//
//  GifCommunicator.h
//  Reactiongifs
//
//  Created by Alexander Jansen on 4/13/14.
//  Copyright (c) 2014 AlexJansen. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
@protocol GifCommunicatorDelegate;

@interface GifCommunicator : NSObject

@property (weak, nonatomic) id<GifCommunicatorDelegate> delegate;

- (void)searchAlbumsAtCoordinate:(NSString *)coordinate;
- (void)searchGalleryAtCoordinate:(NSString *)coordinate;
- (void)searchImageAtCoordinate:(NSString *)coordinate;

@end
