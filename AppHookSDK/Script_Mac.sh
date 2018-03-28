#!/bin/sh

#  Script_Mac.sh
#  AppHookSDK
#
#  Created by AQY on 2018/3/26.
#  Copyright © 2018年 李铁柱. All rights reserved.

#open ${BUILT_PRODUCTS_DIR}
TARGET=~/Desktop/Hook/AppHookSDK/AppHookDemo/AppHookSDK_Mac.framework
rm -rf $TARGET
cp -rf ${BUILT_PRODUCTS_DIR}/AppHookSDK_Mac.framework/Versions/A $TARGET


