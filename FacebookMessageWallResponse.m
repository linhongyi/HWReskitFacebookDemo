//
//  FacebookMessageWallResponse.m
//  RestKitFacebook
//
//  Created by Howard on 13/6/27.
//  Copyright (c) 2013年 howard. All rights reserved.
//

#import "FacebookMessageWallResponse.h"

@implementation FacebookMessageWallResponse

+ (NSDictionary*)elementToPropertyMappings
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"serialNumber", @"id",
            nil];
}
@end
