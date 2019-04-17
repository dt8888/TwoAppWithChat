//
//  ChatViewController.m
//  JSApp
//
//  Created by DT on 2019/4/16.
//  Copyright © 2019年 dayukeji. All rights reserved.
//

#import "ChatViewController.h"
#import <RongIMKit/RongIMKit.h>
@implementation ChatViewController
-(void)viewDidLoad{
    [super viewDidLoad];

}
- (void)didTapCellPortrait:(NSString *)userId{
    RCUserInfo *user = [[RCIM sharedRCIM] getUserInfoCache:userId];
    NSLog(@"用户名称%@",user.userId);
}
@end
