//
//  ConfigMangerData.h
//  技师外快宝
//
//  Created by DT on 2019/3/11.
//  Copyright © 2019年 dayukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
#define ConfigManager                [ConfigMangerData config]
@interface ConfigMangerData : NSObject
+(ConfigMangerData *)config;
-(NSArray *)getMainConfigList;
@end

NS_ASSUME_NONNULL_END
