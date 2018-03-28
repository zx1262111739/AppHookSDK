//
//  HKSocketClient.m
//  AppHookSDK
//
//  Created by AQY on 2018/3/24.
//  Copyright © 2018年 李铁柱. All rights reserved.
//

#import "HKSocketClient.h"
#import "GTMBase64.h"

@interface HKSocketClient ()

@property (nonatomic, copy) NSString * ip;
@property (nonatomic, assign) UInt16 port;
@property (nonatomic, assign) BOOL forceDisconnect;
@end
@implementation HKSocketClient

- (const char *)dispatchQueueLabel {
    return "HKSocketClientQueue";
}
- (void)writeMessage:(NSDictionary *)message {
    
    if (!self.socket.isConnected) {
        HKLog(@"Client disconnect");
        return;
    }
    
    HKSocketPacket * packet = [[HKSocketPacket alloc] init];
    packet.message = message;
    [self writePacket:packet toSocket:self.socket];
}

- (void)connectIp:(NSString *)ip port:(UInt16)port {
    
    self.ip = ip;
    self.port = port;
    NSError * error = nil;
    if (![self.socket connectToHost:ip onPort:port error:&error]) {
        if (error) {
            HKLog(@"Client connect Error: %@", error);
        }
    }
}

- (void)readPakcet:(HKSocketPacket *)packet socket:(GCDAsyncSocket *)socket {
    if (packet.message)
    HKLog(@"%@", [packet.message objectForKey:@"log"]);
}

// MARK: - GCDAsyncSocket
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    [sock readDataWithTimeout:-1 tag:_readTag ++];
    HKLog(@"connect");
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    HKLog(@"Client disconnect");
    [NSTimer scheduledTimerWithTimeInterval:3 repeats:YES block:^(NSTimer * _Nonnull timer) {
        if (self.socket.isConnected) {
            [timer invalidate];
            timer = nil;
        } else {
            [self connectIp:self.ip port:self.port];
        }
    }];
    [[NSRunLoop currentRunLoop] run];
}


@end
