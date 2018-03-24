//
//  HKSocketClient.m
//  AppHookSDK
//
//  Created by AQY on 2018/3/24.
//  Copyright © 2018年 李铁柱. All rights reserved.
//

#import "HKSocketClient.h"

@interface HKSocketClient ()

@property (nonatomic, assign) BOOL forceDisconnect;
@end
@implementation HKSocketClient

- (const char *)dispatchQueueLabel {
    return "HKSocketClientQueue";
}
- (void)writeCommand:(NSString *)command {
    
    if (!self.socket.isConnected) {
        HKLog(@"Client disconnect");
        return;
    }
    
    HKSocketPacket * packet = [[HKSocketPacket alloc] init];
    packet.command = command;
    [self writePacket:packet toSocket:self.socket];
}

- (void)connectIp:(NSString *)ip port:(UInt16)port {
    
    NSError * error = nil;
    if (![self.socket connectToHost:ip onPort:port error:&error]) {
        if (error) {
            HKLog(@"Client connect Error: %@", error);
        }
    }
}

- (void)readPakcet:(HKSocketPacket *)packet socket:(GCDAsyncSocket *)socket {
}

// MARK: - GCDAsyncSocket
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    [sock readDataWithTimeout:-1 tag:_readTag ++];
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    HKLog(@"Client disconnect");
}


@end
