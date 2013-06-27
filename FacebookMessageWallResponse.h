//
//  FacebookMessageWallResponse.h
//  RestKitFacebook
//
//  Created by Howard on 13/6/27.
//  Copyright (c) 2013年 howard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FacebookMessageWallResponse : NSObject

@property (nonatomic,copy) NSString *searialNumber;

+ (NSDictionary*)elementToPropertyMappings;

@end
