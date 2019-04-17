//
//  AppDelegate.h
//  JSApp
//
//  Created by DT on 2019/3/12.
//  Copyright © 2019年 dayukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RongIMLib/RongIMLib.h>
#import <RongIMKit/RongIMKit.h>
@interface AppDelegate : UIResponder<UIApplicationDelegate,RCIMConnectionStatusDelegate>

@property (strong, nonatomic) UIWindow *window;

 @property (assign, nonatomic) UIBackgroundTaskIdentifier backgroundUpdateTask;
@end

