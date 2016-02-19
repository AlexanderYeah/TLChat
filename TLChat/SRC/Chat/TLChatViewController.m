//
//  TLChatViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/15.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatViewController.h"
#import "TLChatHelper.h"

static TLChatViewController *chatVC;

@interface TLChatViewController()

@property (nonatomic, strong) TLChatHelper *helper;

@end

@implementation TLChatViewController

+ (TLChatViewController *) sharedChatVC
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        chatVC = [[TLChatViewController alloc] init];
    });
    return chatVC;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorTableViewBG]];
    
    self.helper = [[TLChatHelper alloc] init];
    self.chatMoreKeyboardData = self.helper.chatMoreKeyboardData;
    
}

@end