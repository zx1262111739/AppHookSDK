//
//  HKParseCommand.m
//  AppHookSDK
//
//  Created by AQY on 2018/3/24.
//  Copyright © 2018年 李铁柱. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HKParseCommand.h"
#import "GTMBase64.h"
#import <objc/runtime.h>

@implementation HKParseCommand

+ (void)parseMessage:(NSDictionary *)message completion:(void (^) (NSDictionary <NSString *, id> * dict))completion {
    
    NSString * command = [message objectForKey:@"command"];
    dispatch_async(dispatch_get_main_queue(), ^{
        HKLog(@"receive command: %@", command);
        if ([command isEqualToString:@"location"]) {
            
            NSString * longitude = [message objectForKey:@"longitude"];
            NSString * latitude = [message objectForKey:@"latitude"];
            
            [[NSUserDefaults standardUserDefaults] setObject:longitude forKey:AppHookSDK_Location_longitude];
            [[NSUserDefaults standardUserDefaults] setObject:latitude forKey:AppHookSDK_Location_latitude];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    });
    
}
@end
