//
//  FacebookAccount.h
//  RestKitFacebook
//
//  Created by Howard on 13/6/26.
//  Copyright (c) 2013年 howard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FacebookAccount : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *first_name;
@property (nonatomic,copy) NSString *last_name;
@property (nonatomic,copy) NSString *link;
@property (nonatomic,copy) NSString *username;
@property (nonatomic,copy) NSString *gender;
@property (nonatomic,copy) NSString *locale;

+ (NSDictionary*)elementToPropertyMappings;

@end
