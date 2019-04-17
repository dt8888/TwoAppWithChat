//
//  BaseTabBarViewController.h
//  技师外快宝
//
//  Created by DT on 2019/3/11.
//  Copyright © 2019年 dayukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTabView.h"
NS_ASSUME_NONNULL_BEGIN
typedef void (^DidSelectImageButtonBlock) (NSInteger index);
@interface BaseTabBarViewController : UITabBarController
{
    BaseTabView *_tabBar;
}
-(void)setTabBar4Num:(int)num; //判断我 图标是否隐藏

-(void)setTabBar3Num:(int)num; //判断订单 图标是否隐藏
@property (nonatomic,copy) DidSelectImageButtonBlock selectBlock;
@end

NS_ASSUME_NONNULL_END
