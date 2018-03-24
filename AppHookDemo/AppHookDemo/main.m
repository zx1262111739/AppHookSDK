//
//  main.m
//  AppHookDemo
//
//  Created by AQY on 2018/3/24.
//  Copyright © 2018年 AQY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Application.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        [Application sharedInstance];
        [[NSRunLoop mainRunLoop] run];
    }
    return 0;
}
