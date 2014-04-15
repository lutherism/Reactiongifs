//
//  GifBuilder.h
//  Reactiongifs
//
//  Created by Alexander Jansen on 4/13/14.
//  Copyright (c) 2014 AlexJansen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GifBuilder : NSObject

+ (NSArray *)albumsFromJSON:(NSData *)objectNotation error:(NSError **)error;
+ (NSArray *)imageFromJSON:(NSData *)objectNotation error:(NSError **)error;
+ (NSArray *)galleryFromJSON:(NSData *)objectNotation error:(NSError **)error;

@end
