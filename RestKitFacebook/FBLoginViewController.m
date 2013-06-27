//
//  FBLoginViewController.m
//  RestKitFacebook
//
//  Created by Howard on 13/6/26.
//  Copyright (c) 2013年 howard. All rights reserved.
//

#import "FBLoginViewController.h"
#import "RestKitFaceBook.h"
#import <QuartzCore/QuartzCore.h>

////////////////////////////////////////////////////////////////////////////////////////////////////

#define postMessage @"Post a Message via RestKitFramework"

////////////////////////////////////////////////////////////////////////////////////////////////////

typedef enum
{
    FBLoginViewControllerButtonTag_getProfile  = 1,
    FBLoginViewControllerButtonTag_queryFriend = 2,
    FBLoginViewControllerButtonTag_postMessage = 3
    
}FBLoginViewControllerButtonTag;

////////////////////////////////////////////////////////////////////////////////////////////////////

@interface FBLoginViewController ()
{
    UIButton    *getProfileButton_;
    UIButton    *postMessageButton_;
    UIButton    *queryFriendButton_;
    
    UITextField *messageText_;
    UITextField *profileIDText_;
}

@property (nonatomic,retain) UIButton    *getProfileButton;
@property (nonatomic,retain) UIButton    *postMessageButton;
@property (nonatomic,retain) UIButton    *queryFriendButton;
@property (nonatomic,retain) UITextField *messageText;
@property (nonatomic,retain) UITextField *profileIDText;

- (void)buttonDidclick:(id)sender;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////

@implementation FBLoginViewController

////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Synthesize

@synthesize getProfileButton  = getProfileButton_;
@synthesize queryFriendButton = queryFriendButton_;
@synthesize postMessageButton = postMessageButton_;
@synthesize messageText       = messageText_;
@synthesize profileIDText     = profileIDText_;

////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Creating, Copying, and Dellocating Object

- (void)dealloc
{
    [getProfileButton_ removeFromSuperview];
    [getProfileButton_ release];
    
    [queryFriendButton_ removeFromSuperview];
    [queryFriendButton_ release];
    
    [postMessageButton_ removeFromSuperview];
    [postMessageButton_ release];
    
    [messageText_ removeFromSuperview];
    [messageText_ release];
    
    [profileIDText_ removeFromSuperview];
    [profileIDText_ release];
    
    [super dealloc];
}

////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Managing the View

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
 
    FBLoginView *loginview = [[FBLoginView alloc] init];
    
    loginview.frame    = CGRectOffset(loginview.frame, 5, 5);
    loginview.delegate = self;
    loginview.center   = CGPointMake(self.view.center.x,30);
    
    [self.view addSubview:loginview];
    
    [loginview sizeToFit];
    
    [loginview release];
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    
    if(self.profileIDText==nil)
    {
        profileIDText_ = [[UITextField alloc]initWithFrame:CGRectMake(5, 200, self.view.bounds.size.width-5, 50)];
    }
    
    if(self.profileIDText!=nil)
    {
        self.profileIDText.borderStyle = UITextBorderStyleRoundedRect;
        
        self.profileIDText.placeholder = @"Enter your ProfileID";
        
        self.profileIDText.returnKeyType = UIReturnKeyDone;
        self.profileIDText.delegate      = self;
        
        [self.view addSubview:self.profileIDText];
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    
    if(self.getProfileButton==nil)
    {
        getProfileButton_ = [[UIButton alloc]initWithFrame:CGRectMake(self.view.center.x-50,250, 100, 50)];
    }
    
    if(self.getProfileButton!=nil)
    {
        self.getProfileButton.tag = FBLoginViewControllerButtonTag_getProfile;
        
        [self.getProfileButton setTitle:@"yourProfile" forState:UIControlStateNormal];
        [self.getProfileButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.getProfileButton setBackgroundColor:[UIColor greenColor]];
        
        [self.getProfileButton addTarget:self action:@selector(buttonDidclick:) forControlEvents:UIControlEventTouchUpInside];
        
        ////////////////////////////////////////////////////////////////////////////////////////////////////
        
        CALayer *layer = self.getProfileButton.layer;
        
        [layer setCornerRadius:5.0];
        [layer setBorderColor:[UIColor redColor].CGColor];
        [layer setBorderWidth:2.0];
        
        ////////////////////////////////////////////////////////////////////////////////////////////////////
        
        [self.view addSubview:self.getProfileButton];
    }

    ////////////////////////////////////////////////////////////////////////////////////////////////////
    
    if(self.queryFriendButton==nil)
    {
        queryFriendButton_ = [[UIButton alloc]initWithFrame:CGRectMake(self.view.center.x-50,350, 100, 50)];
    }
    
    if(self.queryFriendButton!=nil)
    {
        self.queryFriendButton.tag = FBLoginViewControllerButtonTag_queryFriend;
        
        [self.queryFriendButton setTitle:@"GetFriends" forState:UIControlStateNormal];
        [self.queryFriendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.queryFriendButton setBackgroundColor:[UIColor greenColor]];
        
        [self.queryFriendButton addTarget:self action:@selector(buttonDidclick:) forControlEvents:UIControlEventTouchUpInside];
        
        ////////////////////////////////////////////////////////////////////////////////////////////////////
        
        CALayer *layer = self.queryFriendButton.layer;
        
        [layer setCornerRadius:5.0];
        [layer setBorderColor:[UIColor redColor].CGColor];
        [layer setBorderWidth:2.0];
        
        ////////////////////////////////////////////////////////////////////////////////////////////////////
        
        [self.view addSubview:self.queryFriendButton];
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    
    if(self.postMessageButton==nil)
    {
        postMessageButton_ = [[UIButton alloc]initWithFrame:CGRectMake(self.view.center.x-50,150, 100, 50)];
    }
    
    if(self.postMessageButton!=nil)
    {
        self.postMessageButton.tag = FBLoginViewControllerButtonTag_postMessage;
        
        [self.postMessageButton setTitle:@"PostMessage" forState:UIControlStateNormal];

        [self.postMessageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.postMessageButton setBackgroundColor:[UIColor greenColor]];
        
        [self.postMessageButton addTarget:self action:@selector(buttonDidclick:) forControlEvents:UIControlEventTouchUpInside];
        
        ////////////////////////////////////////////////////////////////////////////////////////////////////
        
        CALayer *layer = self.postMessageButton.layer;
        
        [layer setCornerRadius:5.0];
        [layer setBorderColor:[UIColor redColor].CGColor];
        [layer setBorderWidth:2.0];
        
        ////////////////////////////////////////////////////////////////////////////////////////////////////
        
        [self.view addSubview:self.postMessageButton];
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    
    if(self.messageText==nil)
    {
        messageText_ = [[UITextField alloc]initWithFrame:CGRectMake(5, 100, self.view.bounds.size.width-5, 50)];
    }
    
    if(self.messageText!=nil)
    {
        self.messageText.borderStyle = UITextBorderStyleRoundedRect;
        
        self.messageText.placeholder = postMessage;
        
        self.messageText.returnKeyType = UIReturnKeyDone;
    
        self.messageText.delegate = self;
        
        [self.view addSubview:self.messageText];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - UITextfiledDelegate Method

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Button Click Method

- (void)buttonDidclick:(id)sender
{
    if([sender isKindOfClass:[UIButton class]]==NO)
    {
        return;
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    
    UIButton *button = sender;
    
    switch (button.tag)
    {
        case FBLoginViewControllerButtonTag_getProfile:
        {
            if(self.profileIDText.text.length>0)
            {
                [RestKitFaceBook queryProfileWithID:self.profileIDText.text];
            }
            else
            {
                [RestKitFaceBook queryProfileWithID:self.profileIDText.placeholder];
            }
            break;
        }
        case FBLoginViewControllerButtonTag_queryFriend:
        {
            [RestKitFaceBook queryFriends];
            break;
        }
        case FBLoginViewControllerButtonTag_postMessage:
        {
            if(self.messageText.text.length>0)
            {
                [RestKitFaceBook postMessageToWall:self.messageText.text];
            }
            else
            {
                [RestKitFaceBook postMessageToWall:self.messageText.placeholder];
            }
            
            break;
        }
        default:
            break;
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - FBLoginViewDelegate Method

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView;
{
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user;
{
    self.profileIDText.placeholder = user.id;
    
    [RestKitFaceBook setProfileID:user.id];
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView;
{
}

- (void)loginView:(FBLoginView *)loginView
      handleError:(NSError *)error
{
}

@end
