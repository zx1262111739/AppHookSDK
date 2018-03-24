//
//  HKSocket.h
//  AppHookSDK
//
//  Created by AQY on 2018/3/24.
//  Copyright © 2018年 李铁柱. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"

@class HKSocketPacket;
@interface HKSocket : NSObject
<GCDAsyncSocketDelegate> {
    dispatch_queue_t _delegateQueue;
    NSUInteger _readTag;
    NSUInteger _writeTag;
}

@property (nonatomic, strong, readonly) GCDAsyncSocket * socket;
- (const char *)dispatchQueueLabel;

- (void)writePacket:(HKSocketPacket *)packet toSocket:(GCDAsyncSocket *)socket;
- (void)readPakcet:(HKSocketPacket *)packet socket:(GCDAsyncSocket *)socket;
@end

@interface GCDAsyncSocket (HKSocketPacket)
@property (nonatomic, readonly) NSMutableData * packetData;
@end

@interface HKSocketPacket : NSObject
@property (nonatomic, copy) NSString * command;

- (NSData *)coding;
+ (HKSocketPacket *)packetWithData:(NSData *)data outPacketLength:(UInt16 *)outPacketLength;
@end

