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

@implementation HKParseCommand

+ (void)parseMessage:(NSDictionary *)message completion:(void (^) (NSDictionary <NSString *, id> * dict))completion {
    
    NSString * command = [message objectForKey:@"command"];
    dispatch_async(dispatch_get_main_queue(), ^{
        HKLog(@"receive command: %@", command);
        if ([command isEqualToString:@"screenshot"]) {
            
            UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
            
            UIGraphicsBeginImageContextWithOptions(window.bounds.size, NO, 0.0);
            CGContextRef ctx = UIGraphicsGetCurrentContext();
            [window.layer renderInContext:ctx];
            UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            
            NSString * imageString = [GTMBase64 stringByEncodingData:UIImageJPEGRepresentation(image, 0.5)];
            HKLog(@"%@", imageString);
            if (completion) {
                completion(@{@"command" : command, @"image": imageString});
            }
        }
        
    });
    
}
@end
