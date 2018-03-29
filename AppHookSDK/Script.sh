#!/bin/sh

#  Script.sh
#  AppHookSDK
#
#  Created by AQY on 2018/3/24.
#  Copyright © 2018年 李铁柱. All rights reserved.

APP_DIR=~/Documents/inject/wx/Payload/WeChat.app
HOOK_DIR=~/Documents/inject/WxHook

rm -rf ${APP_DIR}/AppHookSDK.framework
rm -rf ${HOOK_DIR}/AppHookSDK.framework

cp -rf ${BUILT_PRODUCTS_DIR}/AppHookSDK.framework ${APP_DIR}/AppHookSDK.framework
cp -rf ${BUILT_PRODUCTS_DIR}/AppHookSDK.framework ${HOOK_DIR}/AppHookSDK.framework



