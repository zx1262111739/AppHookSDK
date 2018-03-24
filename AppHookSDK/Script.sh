#!/bin/sh

#  Script.sh
#  AppHookSDK
#
#  Created by AQY on 2018/3/24.
#  Copyright © 2018年 李铁柱. All rights reserved.

rm -rf ~/Documents/inject/WxHook/AppHookSDK.framework
rm -rf ~/Documents/inject/wx/Payload/WeChat.app/AppHookSDK.framework

cp -r `pwd`/LatestBuild/Debug-iphoneos/AppHookSDK.framework ~/Documents/inject/WxHook/AppHookSDK.framework
cp -r `pwd`/LatestBuild/Debug-iphoneos/AppHookSDK.framework ~/Documents/inject/wx/Payload/WeChat.app/AppHookSDK.framework
