//
//  RestKitFaceBook.m
//  RestKitFacebook
//
//  Created by Howard on 13/6/26.
//  Copyright (c) 2013年 howard. All rights reserved.
//

#import <RestKit.h>
#import <FBSession+Internal.h>
#import <FBAccessTokenData.h>
#import <FacebookAccount.h>

#import "RestKitFaceBook.h"
#import "FacebookFriends.h"
#import "FacebookMessageWallRequest.h"
#import "FacebookMessageWallResponse.h"

////////////////////////////////////////////////////////////////////////////////////////////////////

#define baseURLString @"https://graph.facebook.com/"

////////////////////////////////////////////////////////////////////////////////////////////////////

static NSString *appID_      = @"";
static NSString *profileID_  = @"";

////////////////////////////////////////////////////////////////////////////////////////////////////

@interface RestKitFaceBook()
{
    
}

+ (NSString *)accessToken;
+ (NSString *)profileUrlString;
+ (void)displayAlertWithMessage:(NSString *)message;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////

@implementation RestKitFaceBook

#pragma mark - Private Method

+ (NSString *)accessToken
{
    FBSession *session = [FBSession activeSessionIfOpen];
 
    if(session!=nil)
    {
        return session.accessTokenData.accessToken;
    }
    else
    {
        return nil;
    }
}

+ (void)displayAlertWithMessage:(NSString *)message
{
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Result"
                                                     message:message
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil] autorelease];
    [alert show];
}

+ (NSString *)profileUrlString
{
    return [NSString stringWithFormat:@"%@%@/",baseURLString,profileID_];
}

+ (void) performPublishAction:(void (^)(void)) action
{
    // we defer request for permission to post to the moment of post, then we check for the permission
    if ([FBSession.activeSession.permissions indexOfObject:@"publish_actions"] == NSNotFound) {
        // if we don't already have the permission, then we request it now
        [FBSession.activeSession requestNewPublishPermissions:@[@"publish_actions"]
                                              defaultAudience:FBSessionDefaultAudienceFriends
                                            completionHandler:^(FBSession *session, NSError *error) {
                                                if (!error) {
                                                    action();
                                                }
                                                //For this example, ignore errors (such as if user cancels).
                                            }];
    } else {
        action();
    }
    
}

////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Instance Method

+ (void)setAppID:(NSString *)appID
{
    [appID_ release];
    
    appID_ = [appID copy];
}

+ (void)setProfileID:(NSString *)profileID
{
    [profileID_ release];
    profileID_ = [profileID copy];
}

+ (void)queryProfileWithID:(NSString *)profileID
{
    if(profileID.length<=0)
    {
        return;
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    
    NSString *urlLoginString = [NSString stringWithFormat:@"%@%@/",baseURLString,profileID];
    
    [RKObjectManager setSharedManager:[RKObjectManager managerWithBaseURL:[NSURL URLWithString:[urlLoginString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
    
    // mapping json to class
    RKObjectMapping *requestMapping = [RKObjectMapping requestMapping];
    [requestMapping addAttributeMappingsFromDictionary:[FacebookAccount elementToPropertyMappings]];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:requestMapping pathPattern:@"" keyPath:@"" statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
    
    [[RKObjectManager sharedManager] getObject:nil path:urlLoginString parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
     {
         [self displayAlertWithMessage:mappingResult.dictionary.description];
         
     } failure:^(RKObjectRequestOperation *operation, NSError *error) {
         [self displayAlertWithMessage:error.description];
     }];
}

+ (void)queryFriends
{
    NSString *accessToken = [self accessToken];
    
    if(accessToken==nil)
    {
        return;
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    
    NSString *queryFriendString = [self profileUrlString];

    [RKObjectManager setSharedManager:[RKObjectManager managerWithBaseURL:[NSURL URLWithString:[queryFriendString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
    
    // mapping json to class
    RKObjectMapping *requestMapping = [RKObjectMapping requestMapping];
    [requestMapping addAttributeMappingsFromDictionary:[FacebookFriends elementToPropertyMappings]];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:requestMapping pathPattern:nil keyPath:@"data" statusCodes:[NSIndexSet indexSetWithIndex:200]];

    [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
    
    [[RKObjectManager sharedManager] getObject:nil path:[NSString stringWithFormat:@"friends?access_token=%@",accessToken] parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
     {
         [self displayAlertWithMessage:mappingResult.dictionary.description];
         
         
     } failure:^(RKObjectRequestOperation *operation, NSError *error)
     {
         [self displayAlertWithMessage:error.description];
     }];

}

+ (void)postMessageToWall:(NSString *)message
{
    NSString *accessToken = [self accessToken];
    
    if(accessToken==nil)
    {
        return;
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////
    
    [self performPublishAction:^{
        
        NSString *postMessageToWallString = [self profileUrlString];
        
        [RKObjectManager setSharedManager:[RKObjectManager managerWithBaseURL:[NSURL URLWithString:[postMessageToWallString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
        
        ////////////////////////////////////////////////////////////////////////////////////////////////////
        
        RKObjectMapping *requestMapping = [RKObjectMapping requestMapping];
        [requestMapping addAttributeMappingsFromDictionary:[FacebookMessageWallRequest elementToPropertyMappings]];
        
        [[RKObjectManager sharedManager] addRequestDescriptor:[RKRequestDescriptor requestDescriptorWithMapping:requestMapping objectClass:[FacebookMessageWallRequest class] rootKeyPath:nil]];
        
        ////////////////////////////////////////////////////////////////////////////////////////////////////
        
        RKObjectMapping *responseMapping = [RKObjectMapping requestMapping];
        [responseMapping addAttributeMappingsFromDictionary:[FacebookMessageWallResponse elementToPropertyMappings]];
        
        [[RKObjectManager sharedManager] addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:responseMapping pathPattern:nil keyPath:nil statusCodes:[NSIndexSet indexSetWithIndex:200]]];
        
        ////////////////////////////////////////////////////////////////////////////////////////////////////
        
        FacebookMessageWallRequest *wallRequest = [[FacebookMessageWallRequest alloc]init];
        
        wallRequest.message     = message;
        
        ////////////////////////////////////////////////////////////////////////////////////////////////////
        
        [[RKObjectManager sharedManager]postObject:wallRequest
                                              path:[NSString stringWithFormat:@"feed?access_token=%@",accessToken]parameters:nil
                                           success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
         {
             [self displayAlertWithMessage:mappingResult.description];
             
         } failure:^(RKObjectRequestOperation *operation, NSError *error)
         {
             [self displayAlertWithMessage:error.description];
         }];
        
        [wallRequest release];

    }];
    
}

@end
