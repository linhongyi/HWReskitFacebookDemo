//
//  FacebookFriends.m
//  RestKitFacebook
//
//  Created by Howard on 13/6/26.
//  Copyright (c) 2013年 howard. All rights reserved.
//

#import "FacebookFriends.h"

@implementation FacebookFriends

+ (NSDictionary*)elementToPropertyMappings
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"serialNumber", @"id",
            @"name", @"name",
            nil];
}

@end
