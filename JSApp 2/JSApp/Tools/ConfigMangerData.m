//
//  ConfigMangerData.m
//  技师外快宝
//
//  Created by DT on 2019/3/11.
//  Copyright © 2019年 dayukeji. All rights reserved.
//

#import "ConfigMangerData.h"

@implementation ConfigMangerData
static ConfigMangerData *_config;
+(ConfigMangerData *)config{
    @synchronized(self){
        if (_config==nil) {
            _config=[[ConfigMangerData alloc] init];
        }
    }
    return _config;
}
- (NSDictionary *)returnRoot
{
    NSString *path=[[NSBundle mainBundle] pathForResource:@"MangerData" ofType:@"plist"];
    NSDictionary *root=[[NSDictionary alloc] initWithContentsOfFile:path];
    return root;
}
#pragma 得到本地tabbar 数据
-(NSArray *)getMainConfigList
{
    NSDictionary * root = [self returnRoot];
    NSArray *data=[[NSArray alloc] initWithArray:[root objectForKey:@"MainTabBar"]];
    return data;
}
@end
