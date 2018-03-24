//
//  HKSocket.m
//  AppHookSDK
//
//  Created by AQY on 2018/3/24.
//  Copyright © 2018年 李铁柱. All rights reserved.
//

#import "HKSocket.h"
#import <objc/runtime.h>

@interface HKSocket()
@end

@implementation HKSocket
@synthesize socket = _socket;

- (instancetype)init {
    self = [super init];
    if (self) {
       
        _delegateQueue = dispatch_queue_create([self dispatchQueueLabel], DISPATCH_QUEUE_SERIAL);
        _socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:_delegateQueue];
        
    }
    return self;
}
- (const char *)dispatchQueueLabel {
    return "HKSocket";
}

- (void)writePacket:(HKSocketPacket *)packet toSocket:(GCDAsyncSocket *)socket {
    [socket writeData:[packet coding] withTimeout:30 tag:_writeTag ++];
}
- (void)readPakcet:(HKSocketPacket *)packet socket:(GCDAsyncSocket *)socket {
    
}

// MARK: - GCDAsyncSocketDelegate
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    [sock.packetData appendData:data];
    
    UInt16 packetLength = 0;
    HKSocketPacket * packet = [HKSocketPacket packetWithData:sock.packetData outPacketLength:&packetLength];
    if (packet) {
        [sock.packetData replaceBytesInRange:NSMakeRange(0, packetLength) withBytes:NULL length:0];
        [self readPakcet:packet socket:sock];
    }
    [sock readDataWithTimeout:-1 tag:_readTag ++];
}
@end


@implementation GCDAsyncSocket (HKSocketPacket)

- (NSMutableData *)packetData {
    
    const char * key = "HKSocketPacket";
    NSMutableData * mData = objc_getAssociatedObject(self, key);
    if (mData == nil) {
        mData = [[NSMutableData alloc] init];
        objc_setAssociatedObject(self, key, mData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return mData;
}
@end

@implementation HKSocketPacket

- (NSData *)coding {
    
    NSData * commandData = [self.command dataUsingEncoding:NSUTF8StringEncoding];
    
    UInt16 packetId = htons(0x8F2D);
    NSMutableData * data = [[NSMutableData alloc] initWithBytes:&packetId length:2];
    
    UInt16 length = htons(commandData.length);
    [data appendBytes:&length length:2];
    
    [data appendData:commandData];
    return data;
}


+ (HKSocketPacket *)packetWithData:(NSData *)data outPacketLength:(UInt16 *)outPacketLength {
    if (data.length < 4) return nil;
    
    UInt16 packetId = *((UInt16 *)[[data subdataWithRange:NSMakeRange(0, 2)] bytes]);
    packetId = ntohs(packetId);
    if (packetId != 0x8F2D) {
        return nil;
    }
    
    UInt16 length = *((UInt16 *)[[data subdataWithRange:NSMakeRange(2, 2)] bytes]);
    length = ntohs(length);
    
    if (data.length - 4 < length && length != 0) {
        return nil;
    }
    
    if (outPacketLength != NULL) {
        *outPacketLength = length + 4;
    }
    
    HKSocketPacket * packet = [[HKSocketPacket alloc] init];
    if (length > 0) {
        packet.command = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(4, length)] encoding:NSUTF8StringEncoding];
    }
    return packet;
}


@end
