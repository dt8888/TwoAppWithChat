//
//  ViewController.m
//  JSApp
//
//  Created by DT on 2019/3/12.
//  Copyright © 2019年 dayukeji. All rights reserved.
//

#import "StartViewController.h"
#import "BaseTabBarViewController.h"
@interface StartViewController ()
{
    BaseTabBarViewController *_tabBarVC;
}
@end

@implementation StartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loginRongCloud];
  
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)loginRongCloud
{
    //登录融云服务器,开始阶段可以先从融云API调试网站获取，之后token需要通过服务器到融云服务器取。
    NSString*token=@"wvCnJwmdDgIEBsLc/Nd3PNR8j9cg/ei6hXcHg/FT6GRqrHOIO5ljurf5oZI7u+xOh6MlaGKLUA+BelZD/QzHbA==";
    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
        //设置用户信息提供者,页面展现的用户头像及昵称都会从此代理取
        [[RCIM sharedRCIM] setUserInfoDataSource:self];
//        [RCIM sharedRCIM].globalConversationAvatarStyle = RC_USER_AVATAR_CYCLE; // 列表页头像的形状，我设置成了圆形
//        [RCIM sharedRCIM].globalConversationPortraitSize  = CGSizeMake(36, 36);
        //刷新融云对应用户信息
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = @"666666";
        user.name = @"用户2";
        user.portraitUri = @"https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=1756054607,4047938258&fm=96&s=94D712D20AA1875519EB37BE0300C008";
        [[RCIM sharedRCIM]refreshUserInfoCache:user withUserId:userId];
        NSLog(@"Login successfully with userId: %@.", userId);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            BaseTabBarViewController *controller=[[BaseTabBarViewController alloc]init];
            [self addChildViewController:controller];
            [self.view addSubview:controller.view];
            
        });
        
    } error:^(RCConnectErrorCode status) {
        NSLog(@"login error status: %ld.", (long)status);
    } tokenIncorrect:^{
        NSLog(@"token 无效 ，请确保生成token 使用的appkey 和初始化时的appkey 一致");
    }];
    
}
/**
 *此方法中要提供给融云用户的信息，建议缓存到本地，然后改方法每次从您的缓存返回
 */
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void(^)(RCUserInfo* userInfo))completion
{
    //此处为了演示写了一个用户信息
    if ([@"123456" isEqual:userId]) {
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = @"123456";
        user.extra = @"全国总店";
        user.name = @"dddd";
        user.portraitUri = @"https://kxlj.oss-cn-hangzhou.aliyuncs.com/diary-pic/15547206992190";
        return completion(user);
    }else if([@"222222" isEqual:userId]) {
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = @"222222";
        user.name = @"用户3";
        user.portraitUri = @"https://kxlj.oss-cn-hangzhou.aliyuncs.com/diary-pic/15547206992190";
        return completion(user);
    }
}
@end
