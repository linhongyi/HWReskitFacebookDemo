//
//  FacebookAccount.m
//  RestKitFacebook
//
//  Created by Howard on 13/6/26.
//  Copyright (c) 2013年 howard. All rights reserved.
//

#import "FacebookAccount.h"

@interface FacebookAccount()
{
  @private
    NSString *name_;
    NSString *first_name_;
    NSString *last_name_;
    NSString *link_;
    NSString *username_;
    NSString *gender_;
    NSString *locale_;
}

@end

////////////////////////////////////////////////////////////////////////////////////////////////////

@implementation FacebookAccount

@synthesize name       = name_;
@synthesize first_name = first_name_;
@synthesize last_name  = last_name_;
@synthesize link       = link_;
@synthesize username   = username_;
@synthesize gender     = gender_;
@synthesize locale     = locale_;

+ (NSDictionary*)elementToPropertyMappings
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"name", @"name",
            @"first_name", @"first_name",
            @"last_name", @"last_name",
            @"link", @"link",
            @"username", @"username",
            @"gender", @"gender",
            @"locale", @"locale",
            nil];

}

@end
