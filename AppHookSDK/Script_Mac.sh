#!/bin/sh

#  Script_Mac.sh
#  AppHookSDK
#
#  Created by AQY on 2018/3/26.
#  Copyright © 2018年 李铁柱. All rights reserved.

rm -rf ~/Documents/inject/AppHookSDK/AppHookDemo/AppHookSDK_Mac.framework

cp -r `pwd`/LatestBuild/Debug-iphoneos/AppHookSDK.framework ~/Documents/inject/AppHookSDK/AppHookDemo/AppHookSDK_Mac.framework
