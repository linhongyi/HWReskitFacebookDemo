//
//  FacebookMessageWallRequest.m
//  RestKitFacebook
//
//  Created by Howard on 13/6/27.
//  Copyright (c) 2013年 howard. All rights reserved.
//

#import "FacebookMessageWallRequest.h"

@implementation FacebookMessageWallRequest

- (NSDictionary *)paramater
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            self.message, @"message",
            nil];
}

+ (NSDictionary*)elementToPropertyMappings
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"message"    , @"message",
            nil];
}

@end
