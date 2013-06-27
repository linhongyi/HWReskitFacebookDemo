//
//  RestKitFaceBook.h
//  RestKitFacebook
//
//  Created by Howard on 13/6/26.
//  Copyright (c) 2013年 howard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RestKitFaceBook : NSObject

////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - class method

+ (void)setAppID:(NSString *)appID;
+ (void)setProfileID:(NSString *)profileID;

+ (void)queryProfileWithID:(NSString *)profileID;
+ (void)queryFriends;
+ (void)postMessageToWall:(NSString *)message;

////////////////////////////////////////////////////////////////////////////////////////////////////

@end
