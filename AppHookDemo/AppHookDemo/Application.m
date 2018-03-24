//
//  Application.m
//  AppHookDemo
//
//  Created by AQY on 2018/3/24.
//  Copyright © 2018年 AQY. All rights reserved.
//

#import "Application.h"

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
    [client connectIp:@"10.0.0.25" port:9002];

    char command[512] = {0};
    char enterKey;
    while (1) {
        HKLog(@"input command:");
        scanf("%[^\n]", command);
        scanf("%c", &enterKey);
        
        [client writeCommand:[NSString stringWithCString:command encoding:NSUTF8StringEncoding]];
        command[0] = '\0';
    }

    
//    server = [[HKSocketServer alloc] init];
//    [server acceptPort:9002];
//
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        client = [[HKSocketClient alloc] init];
//        [client connectIp:@"127.0.0.1" port:9002];
//
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            char command[512] = {0};
//            char enterKey;
//            while (1) {
//                HKLog(@"input command:");
//                scanf("%[^\n]", command);
//                scanf("%c", &enterKey);
//
//                [client writeCommand:[NSString stringWithCString:command encoding:NSUTF8StringEncoding]];
//                command[0] = '\0';
//            }
//        });
//    });
}

@end

