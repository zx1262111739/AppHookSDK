//
//  HKSocketServer.h
//  WxHook
//
//  Created by 李铁柱 on 2018/3/23.
//

#import "HKSocket.h"

@interface HKSocketServer : HKSocket

- (void)acceptPort:(UInt16)prot;
@end
