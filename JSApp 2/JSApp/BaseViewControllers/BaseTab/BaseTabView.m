//
//  BaseTabView.m
//  技师外快宝
//
//  Created by DT on 2019/3/11.
//  Copyright © 2019年 dayukeji. All rights reserved.
//

#import "BaseTabView.h"
@implementation BaseTabView
{
    CGFloat tabBarHigh;
    UIButton *_fristBtn;
}
-(void)addButtonWithImage:(UIImage *)image selectedImage:(UIImage *) selectedImage index:(int)index title:(NSString *)title tabbarCount:(NSInteger)count{
    if(kScreenWidth==320)
    {
        tabBarHigh = 49;
    }else
    {
        tabBarHigh =81;
    }
    [self setBackgroundColor:[UIColor whiteColor]];
    CGRect rect = self.bounds;
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
    rect.size.height = tabBarHigh;
    rect.origin.y = -5;
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = CGSizeMake(0, 3);
    self.layer.shadowOpacity = 0.2;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:rect].CGPath;
//    self.layer.shadowColor = RGBA(59, 74, 116, 1).CGColor;
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    if(index==0){
        _fristBtn = btn;
    }
    CGFloat btnWidth=kScreenWidth/count;
    CGFloat x = index*btnWidth;
    int y = 6;
    btn.frame = CGRectMake(x, 0, btnWidth, tabBarHigh);
    UIImageView *btnImage = [[UIImageView alloc]initWithFrame:CGRectMake(btnWidth/2-image.size.width/2, y, image.size.width, image.size.height)];
//    if(USERMODEL.runYJBaseDataModel.isYjmallTabShow!=nil&&[USERMODEL.runYJBaseDataModel.isYjmallTabShow isEqualToString:@"Y"]){
//        if(index==2){
//            btnImage.frame = CGRectMake(btnWidth/2-image.size.width/2, -25+y, image.size.width, image.size.height);
//        }
//    }
    btnImage.tag = 10+index;
    btnImage.image = image;
    [btn addSubview:btnImage];
    
    UILabel *lbl= [MyUtility createLabelWithFrame:CGRectMake(0, btnImage.bottom+4, btnWidth, 16) title:title textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:10] textAlignment:NSTextAlignmentCenter numberOfLines:0];
//    if(USERMODEL.runYJBaseDataModel.isYjmallTabShow!=nil&&[USERMODEL.runYJBaseDataModel.isYjmallTabShow isEqualToString:@"Y"]){
//        if(index==2){
//            lbl.frame = CGRectMake(0, btnImage.bottom-8, btnWidth, 16);
//        }
//    }

    lbl.tag=100+index;
    [btn addSubview:lbl];
    btn.tag=1000+index;
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
//    //小红点提示
//    if (index==count-1) {
//        UIImageView *redIMG=[[UIImageView alloc]initWithFrame:CGRectMake(x+btnImage.right-4, btnImage.top-3, 10, 10)];
//        [redIMG setLayerMasksCornerRadius:redIMG.height/2 BorderWidth:1 borderColor:[UIColor whiteColor]];
//        [redIMG setBackgroundColor:HEXColor(0xf84949,1)];
//        redIMG.hidden=YES;
//        _meRedImageView=redIMG;
//        [self addSubview:redIMG];
//    }else if (index==count-2){
//        UIImageView *redIMG=[[UIImageView alloc]initWithFrame:CGRectMake(x+btnImage.right-4, btnImage.top-3, 10, 10)];
//        [redIMG setLayerMasksCornerRadius:redIMG.height/2 BorderWidth:1 borderColor:[UIColor whiteColor]];
//        [redIMG setBackgroundColor:HEXColor(0xf84949,1)];
//        redIMG.hidden=YES;
//        _orderRedImageView=redIMG;
//        [self addSubview:redIMG];
//    }
    //如果是第一个按钮, 则选中(按顺序一个个添加)
    if (self.subviews.count == 1) {
        [self clickBtn:btn];
    }
}

//返回页面
-(void)setBackHomePage{
    NSLog(@"%@",_fristBtn);
    [self clickBtn:_fristBtn];
}
/**
 *  自定义TabBar的按钮按下事件
 */
- (void)clickBtnDown:(UIButton *)button{
    NSInteger index=button.tag-1000;
    NSInteger oldIndex=self.selectedBtn.tag-1000;
    if (index==oldIndex) {
        return;
    }
    NSArray *_tabConfigList;
    _tabConfigList =  [ConfigManager getMainConfigList];
    NSDictionary *dic=[_tabConfigList objectAtIndex:index];
    NSString *imageNameSel = [dic objectForKey:@"highlightedImage"];
    UIImageView *imgView=[button viewWithTag:index+10];
    imgView.image=Image(imageNameSel);
}
/**
 *  自定义TabBar的按钮点击事件
 */
- (void)clickBtn:(UIButton *)button {
    
    NSInteger index = button.tag-1000;
    NSInteger oldIndex = self.selectedBtn.tag-1000;
    if (index == oldIndex) {
        return;
    }
    UILabel *lbl=[button viewWithTag:index+100];
    lbl.textColor=visualThemeColor;
    NSMutableArray * _tabConfigList = [NSMutableArray arrayWithArray:[ConfigManager getMainConfigList]];
//    if(USERMODEL.runYJBaseDataModel.isYjmallTabShow==nil||[USERMODEL.runYJBaseDataModel.isYjmallTabShow isEqualToString:@"N"]){
//        [_tabConfigList removeObjectAtIndex:2];
//    }
    NSDictionary *dic = [_tabConfigList objectAtIndex:index];
    NSString *imageNameSel = [dic objectForKey:@"highlightedImage"];
    UIImageView *imgView = [button viewWithTag:index+10];
    imgView.image = Image(imageNameSel);
    self.selectedBtn.selected = NO;
    if (oldIndex<0) {
        oldIndex=0;
    }
    
    lbl=[self.selectedBtn viewWithTag:oldIndex+100];
    lbl.textColor=[UIColor blackColor];
    imgView=[self.selectedBtn viewWithTag:oldIndex+10];
    NSDictionary *dic2=[_tabConfigList objectAtIndex:oldIndex];
    NSString *imageNameunSel = [dic2 objectForKey:@"image"];
    imgView.image=Image(imageNameunSel);
    
    //2.再将当前按钮设置为选中
    button.selected = YES;
    
    //3.最后把当前按钮赋值为之前选中的按钮
    self.selectedBtn = button;
    
    //1.先将之前选中的按钮设置为未选中
    
    //却换视图控制器的事情,应该交给controller来做
    //最好这样写, 先判断该代理方法是否实现
    if ([self.delegate respondsToSelector:@selector(tabBar:selectedFrom:to:)]) {
        [self.delegate tabBar:self selectedFrom:self.selectedBtn.tag to:button.tag];
    }
}
@end
