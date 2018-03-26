//
//  HKParseCommand.h
//  AppHookSDK
//
//  Created by AQY on 2018/3/24.
//  Copyright © 2018年 李铁柱. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HKParseCommand : NSObject

+ (void)parseMessage:(NSDictionary *)message completion:(void (^) (NSDictionary <NSString *, id> * dict))completion;
@end
