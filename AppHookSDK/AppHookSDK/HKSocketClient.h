//
//  HKSocketClient.h
//  AppHookSDK
//
//  Created by AQY on 2018/3/24.
//  Copyright © 2018年 李铁柱. All rights reserved.
//

#import "HKSocket.h"

@interface HKSocketClient : HKSocket

- (void)writeCommand:(NSString *)command;
- (void)connectIp:(NSString *)ip port:(UInt16)port;
@end
