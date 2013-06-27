//
//  FacebookFriends.h
//  RestKitFacebook
//
//  Created by Howard on 13/6/26.
//  Copyright (c) 2013年 howard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FacebookFriends : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *serialNumber;

+ (NSDictionary*)elementToPropertyMappings;

@end
