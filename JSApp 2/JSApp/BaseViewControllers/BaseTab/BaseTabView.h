//
//  BaseTabView.h
//  技师外快宝
//
//  Created by DT on 2019/3/11.
//  Copyright © 2019年 dayukeji. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class BaseTabView;
@protocol BaseTabViewDelegate <NSObject>
/**
 *  工具栏按钮被选中, 记录从哪里跳转到哪里. (方便以后做相应特效)
 */
- (void) tabBar:(BaseTabView *)tabBar selectedFrom:(NSInteger) from to:(NSInteger)to;

@end
@interface BaseTabView : UIView
@property (nonatomic, weak) UIButton *selectedBtn;
@property(nonatomic,weak) id<BaseTabViewDelegate> delegate;
-(void)addButtonWithImage:(UIImage *)image selectedImage:(UIImage *) selectedImage index:(int)index title:(NSString *)title tabbarCount:(NSInteger)count;
- (void)clickBtn:(UIButton *)button;
@end

NS_ASSUME_NONNULL_END
