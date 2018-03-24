//
//  HKParseCommand.m
//  AppHookSDK
//
//  Created by AQY on 2018/3/24.
//  Copyright © 2018年 李铁柱. All rights reserved.
//

#import "HKParseCommand.h"
#import <UIKit/UIKit.h>

@implementation HKParseCommand

+ (void)parseCommand:(NSString *)command completion:(void (^) (void))completion {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        HKLog(@"receive command: %@", command);
        if ([command isEqualToString:@"Alert"]) {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Hello Wrold!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
        
    });
    
}
@end
