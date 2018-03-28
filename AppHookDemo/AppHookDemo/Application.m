//
//  Application.m
//  AppHookDemo
//
//  Created by AQY on 2018/3/24.
//  Copyright © 2018年 AQY. All rights reserved.
//

#import "Application.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface Application () {
    HKSocketServer * server;
    HKSocketClient * client;
}
@end
@implementation Application

+ (instancetype)sharedInstance {
    
    static Application * app = nil;
    if (app == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            app = [[Application alloc] init];
        });
    }
    return app;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self applicationFinishLaunch];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"Application Exit");
}

// MARK: - Application Launch
- (void)applicationFinishLaunch {
    
    client = [[HKSocketClient alloc] init];
    objc_msgSend(client, sel_getUid("connectIp:port:"), @"192.168.3.2", 9002);
    HKLog(@"asd");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [client writeMessage:@{@"command" : @"location", @"longitude" : @"-74.186207", @"latitude" : @"40.754855"}];
    });
}

@end

