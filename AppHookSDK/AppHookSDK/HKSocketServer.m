//
//  HKSocketServer.m
//  WxHook
//
//  Created by 李铁柱 on 2018/3/23.
//

#import "HKSocketServer.h"
#import "HKParseCommand.h"
@interface HKSocketServer ()

@property (nonatomic, strong) NSMutableSet <GCDAsyncSocket *> * sockets;
@end

@implementation HKSocketServer

- (instancetype)init {
    self = [super init];
    if (self) {
        self.sockets = [[NSMutableSet alloc] init];
    }
    return self;
}

- (void)acceptPort:(UInt16)prot {
    NSError * error = nil;
    if (![self.socket acceptOnPort:prot error:&error]) {
        HKLog(@"Start Error: %@", error);
        return;
    }
    HKLog(@"Socket Server Start 9002");
}

- (const char *)dispatchQueueLabel {
    return "HKSocketServerQueue";
}

- (void)readPakcet:(HKSocketPacket *)packet socket:(GCDAsyncSocket *)socket {
    [HKParseCommand parseMessage:packet.message completion:^(NSDictionary<NSString *,id> * dict) {
        HKSocketPacket * resPacket = [[HKSocketPacket alloc] init];
        resPacket.message = dict;
        [self writePacket:resPacket toSocket:socket];
    }];
}

// MARK: - GCDAsyncSocketDelegate
- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket {
    [self.sockets addObject:newSocket];
    [newSocket readDataWithTimeout:-1 tag:_readTag ++];
}


- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    [self.sockets removeObject:sock];
}

@end
