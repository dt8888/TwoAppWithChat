//
//  MyPurseViewController.m
//  技师外快宝
//
//  Created by DT on 2019/3/11.
//  Copyright © 2019年 dayukeji. All rights reserved.
//

#import "MyPurseViewController.h"
#import "ChatViewController.h"
@interface MyPurseViewController ()
@property (nonatomic, strong) UIView *tableHeaderView;
@end

@implementation MyPurseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    
    self.conversationListTableView.tableHeaderView = self.tableHeaderView; //设置tableView头部
    self.conversationListTableView.tableFooterView = [UIView new];//这样就不会显示多余的分割线啦
    self.conversationListTableView.backgroundColor = [UIColor whiteColor];// 背景色嘛，clearColor尽量不要用哦，为什么？自行百度！
    self.conversationListTableView.layoutMargins = UIEdgeInsetsZero;
    self.conversationListTableView.separatorInset = UIEdgeInsetsZero;
    self.topCellBackgroundColor = [UIColor blueColor]; // 置顶的消息背景颜色,
    
    //设置需要显示哪些类型的会话
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),@(ConversationType_GROUP)]];
  //设置需要将哪些类型的会话在会话列表中聚合显示
    [self setCollectionConversationType:@[
                                          @(ConversationType_PRIVATE)]];
    //自定义导航左右按钮
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"单聊" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemPressed:)];
    [rightButton setTintColor:[UIColor redColor]];
    self.navigationItem.rightBarButtonItem = rightButton;
    self.conversationListTableView.tableFooterView = [UIView new];
    
}
-(void)rightBarButtonItemPressed:(id)sender
{
    ChatViewController *conversationVC = [[ChatViewController alloc]init];
    conversationVC.hidesBottomBarWhenPushed = YES;
    conversationVC.conversationType =ConversationType_PRIVATE;
    conversationVC.targetId = @"222222";
   
    [self.navigationController pushViewController:conversationVC animated:YES];
    
}
/**
 *重写RCConversationListViewController的onSelectedTableRow事件
 *
 *  @param conversationModelType 数据模型类型
 *  @param model                 数据模型
 *  @param indexPath             索引
 */
-(void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath
{
    ChatViewController *conversationVC = [[ChatViewController alloc]init];
    conversationVC.conversationType =model.conversationType;
    conversationVC.targetId = model.targetId;
     conversationVC.title = model.conversationTitle;
    conversationVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:conversationVC animated:YES];
}
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    RCConversationModel *model = self.conversationListDataSource[indexPath.row];
    UITableViewRowAction *deleteRoWAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        [[RCIMClient sharedRCIMClient] removeConversation:ConversationType_PRIVATE targetId:model.targetId];
        [self refreshConversationTableViewIfNeeded];
        
    }];
    UITableViewRowAction *readRoWAction;
    if (model.unreadMessageCount > 0) {
        readRoWAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"标为已读" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            [[RCIMClient sharedRCIMClient] clearMessagesUnreadStatus:ConversationType_PRIVATE targetId:model.targetId];
            
            [self refreshConversationTableViewIfNeeded];
        }];
    } else {
        readRoWAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"标为未读" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            [[RCIMClient sharedRCIMClient] setMessageReceivedStatus:model.lastestMessageId receivedStatus:ReceivedStatus_UNREAD];
            [self refreshConversationTableViewIfNeeded];// 刷新tableView
        }];
    }
    UITableViewRowAction *topRoWAction;
    if (model.isTop) {
        topRoWAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"取消置顶" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            [[RCIMClient sharedRCIMClient] setConversationToTop:1 targetId:model.targetId isTop:NO];
            [self refreshConversationTableViewIfNeeded];
        }];
        topRoWAction.backgroundColor = [UIColor redColor];
    } else {
        topRoWAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"置顶" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            [[RCIMClient sharedRCIMClient] setConversationToTop:1 targetId:model.targetId isTop:YES];
            [self refreshConversationTableViewIfNeeded];
        }];
        topRoWAction.backgroundColor =  [UIColor redColor];
    }
    return @[deleteRoWAction, readRoWAction, topRoWAction];
}

- (UIView *)tableHeaderView {
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,60)];
        _tableHeaderView.backgroundColor = [UIColor redColor];
    }
    return _tableHeaderView;
}
@end
