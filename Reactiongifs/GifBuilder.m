//
//  GifBuilder.m
//  Reactiongifs
//
//  Created by Alexander Jansen on 4/13/14.
//  Copyright (c) 2014 AlexJansen. All rights reserved.
//

#import "GifBuilder.h"
#import "Gif.h"
#import "Album.h"

@implementation GifBuilder
+ (NSArray *)imageFromJSON:(NSData *)objectNotation error:(NSError **)error
{
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    NSMutableArray *gifs = [[NSMutableArray alloc] init];
    
    NSArray *data = [parsedObject valueForKey:@"data"];
    NSArray *results = [data valueForKey:@"images"];
    NSLog(@"Count %lu", (unsigned long)[results count]);
    
    for (NSDictionary *groupDic in results) {
        Gif *gif = [[Gif alloc] init];
        
        for (NSString *key in groupDic) {
            if ([gif respondsToSelector:NSSelectorFromString(key)]) {
                [gif setValue:[groupDic valueForKey:key] forKey:key];
            }
        }
        
        [gifs addObject:gif];
    }
    
    return gifs;
}
+ (NSArray *)galleryFromJSON:(NSData *)objectNotation error:(NSError **)error
{
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    NSMutableArray *gifs = [[NSMutableArray alloc] init];
    
    NSArray *results = [parsedObject valueForKey:@"results"];
    
    for (NSDictionary *groupDic in results) {
        Gif *gif = [[Gif alloc] init];
        
        for (NSString *key in groupDic) {
            if ([gif respondsToSelector:NSSelectorFromString(key)]) {
                [gif setValue:[groupDic valueForKey:key] forKey:key];
            }
        }
        
        [gifs addObject:gif];
    }
    
    return gifs;
}
+ (NSArray *)albumsFromJSON:(NSData *)objectNotation error:(NSError **)error
{
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    NSMutableArray *albums = [[NSMutableArray alloc] init];
    
    NSArray *results = [parsedObject valueForKey:@"data"];
    
    for (NSDictionary *groupDic in results) {
        Album *album = [[Album alloc] init];
        
        for (NSString *key in groupDic) {
            if ([album respondsToSelector:NSSelectorFromString(key)]) {
                [album setValue:[groupDic valueForKey:key] forKey:key];
            }
        }
        
        [albums addObject:album];
    }
    
    return albums;
}
@end
