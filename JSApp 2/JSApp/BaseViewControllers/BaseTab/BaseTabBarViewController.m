//
//  BaseTabBarViewController.m
//  技师外快宝
//
//  Created by DT on 2019/3/11.
//  Copyright © 2019年 dayukeji. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "MyPurseViewController.h"
#import "SharesViewController.h"
#import "MyOrderViewController.h"
#import "MineViewController.h"
#import "BaseNavViewController.h"
@interface BaseTabBarViewController ()<BaseTabViewDelegate>

@end

@implementation BaseTabBarViewController
{
    CGFloat tabBarHigh;
}
- (NSArray *)createTabItemArr
{
    NSArray * _tabConfigList = [ConfigManager getMainConfigList];
    NSMutableArray *item = [NSMutableArray array];
    for (int i = 0; i < _tabConfigList.count; i ++)
    {
     
            switch (i) {
                case 0:
                {
                    MyPurseViewController *item0 = [[MyPurseViewController alloc] init];
                    BaseNavViewController *nav = [[BaseNavViewController alloc] initWithRootViewController:item0];
                    [item addObject:nav];
                    
                }
                    break;
                case 1:
                {
                    MyOrderViewController *item3 = [[MyOrderViewController alloc] init];
                    BaseNavViewController *nav = [[BaseNavViewController alloc] initWithRootViewController:item3];
                    [item addObject:nav];
                    
                }
                    break;
                case 3:
                {
                    SharesViewController *item2= [[SharesViewController alloc] init];
                    BaseNavViewController *nav = [[BaseNavViewController alloc] initWithRootViewController:item2];
                    [item addObject:nav];
                }
                    break;
                case 4:
                {
                    MineViewController *item3 = [[MineViewController alloc] init];
                    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:item3];
                    [item addObject:nav];
                }
                    break;
                default:
                    break;
            }
        }
    return item;
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationChangeTabBarSelectedIndex object:nil];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent=NO;
    // 删除系统自动生成的UITabBarButton
    //[self removeTabBarButton];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    if(kScreenWidth==320)
    {
        tabBarHigh = 49;
    }else
    {
        tabBarHigh =tabBarHeigh;
    }
    self.viewControllers = [self createTabItemArr];
    
    CGRect tabFrame = self.tabBar.frame; //self.TabBar is IBOutlet of your TabBar
    tabFrame.size.height = tabBarHigh;
    tabFrame.origin.y = self.view.frame.size.height - tabBarHigh;
    self.tabBar.frame = tabFrame;
    
    CGRect rect = self.tabBar.bounds;
    // rect.origin.y=
    
    BaseTabView *myView = [[BaseTabView alloc] init]; //设置代理必须改掉前面的类型,不能用UIView
    _tabBar=myView;
    myView.delegate = self; //设置代理
    myView.frame = rect;
    [self.tabBar addSubview:myView]; //添加到系统自带的tabBar上, 这样可以用的的事件方法. 而不必自己去写
    //为控制器添加按钮
    NSMutableArray * _tabConfigList = [NSMutableArray arrayWithArray:[ConfigManager getMainConfigList]];
    NSInteger count = _tabConfigList.count;
    for (int i=0; i<count; i++) { //根据有多少个子视图控制器来进行添加按钮
        NSDictionary *dic=[_tabConfigList objectAtIndex:i];
        NSString *imageName = [dic objectForKey:@"image"];
        NSString *imageNameSel = [dic objectForKey:@"highlightedImage"];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImage *imageSel = [UIImage imageNamed:imageNameSel];
        [myView addButtonWithImage:image selectedImage:imageSel index:i title:dic[@"title"] tabbarCount:count];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setTabBarSelected:) name:NotificationChangeTabBarSelectedIndex object:nil];
}
/**永远别忘记设置代理*/
- (void)tabBar:(BaseTabView *)tabBar selectedFrom:(NSInteger)from to:(NSInteger)to {
    NSInteger index = to-1000;
    self.selectedIndex = index;
}
-(void)setTabBarSelected:(NSNotification *)notification
{
    int selIndex=[[notification object]intValue];
    
    self.selectedIndex=selIndex;
    UIButton *btn=[_tabBar viewWithTag:1000+selIndex];
    [_tabBar clickBtn:btn];
}
@end
