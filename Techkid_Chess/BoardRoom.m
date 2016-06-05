//
//  ChatRoom.m
//  Techkid_Chess
//
//  Created by admin on 5/29/16.
//  Copyright © 2016 TechKid. All rights reserved.
//

#import "BoardRoom.h"
#import "NetworkConfig.h"
#import "Utils.h"
#import <Techkid_Chess-Swift.h>
#import "Message.h"


@interface BoardRoom ()

@property SocketIOClient* socket;
@property BOOL roomReady;
@property NetworkConfig* networkConfig;

@end

@implementation BoardRoom

- (instancetype)init {
    self = [super init];
    if(self) {
        self.roomReady = NO;
        self.networkConfig = [NetworkConfig sharedInstance];
    }
    return self;
}

- (void)startSocket; {
    
    self.socket = [[SocketIOClient alloc] initWithSocketURL:[NetworkConfig sharedInstance].url options:@{@"log": @YES, @"forcePolling": @YES}];
    
    [self.socket on:@"connect" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"socket connected");
        [self.socket emit:@"user_id" withItems:@[self.networkConfig.userName]];
        [self createRoom:self.networkConfig.roomName userId:@[self.networkConfig.userName] complete:^(BOOL result, NSString *roomName) {
            if (result) {
                self.roomReady = YES;
                if(self.delegate != nil && [self.delegate respondsToSelector:@selector(onRoomReady)]){
                    [self.delegate onRoomReady];
                }
            }
        }];
    }];
    
    [self.socket on:@"room_result" callback:^(NSArray* data, SocketAckEmitter* ack) {
        self.roomReady = YES;
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(onRoomReady)]){
            [self.delegate onRoomReady];
        }
    }];
    
    [self.socket on:@"message" callback:^(NSArray* data, SocketAckEmitter* ack) {
        [self handleOnMessage:data ack:ack];
    }];
    
    [self.socket emit:@"list_message" withItems:@[@"0", @"1000000", self.networkConfig.roomName]];
    [self.socket on:@"list_message_result" callback:^(NSArray* data, SocketAckEmitter* ack) {
        [self handleOnListMessage:data ack:ack];
    }];
    
    [self.socket connect];

}

//- (void) sendMessage:(NSDictionary *)data {
//    if (self.roomReady) {
//        NSString* message = [Utils stringJSONByDictionary:data];
//        NSLog(@"message: %@", message);
//        [self.socket emit:@"message" withItems:@[message, self.networkConfig.roomName, self.networkConfig.userName]];
//        
//     }
//}

- (BOOL) sendMessage: (Message*) message; {
    if(self.roomReady) {
        NSString* msgString = [Utils stringJSONByDictionary:[message getMessageData]];
        
        NSLog(@"message: %@", msgString);
        [self.socket emit:@"message" withItems:@[msgString, self.networkConfig.roomName, self.networkConfig.userName]];
        return YES;
    }
    return NO;
}

- (void) createRoom:(NSString *)roomName userId:(NSArray *)arrUserId complete:(void(^)(BOOL result, NSString *roomName)) completion;
{
    NSString *strUserId = [arrUserId componentsJoinedByString:@";"];
    [self.socket emit:@"create_room" withItems:@[roomName, strUserId]];
    [self.socket once:@"create_room_success" callback:^(NSArray* data, SocketAckEmitter* ack) {
        [self.socket emit:@"join_room" withItems:@[data[0]]];
        if(completion)
            completion(YES, data[0]);
    }];
    
    [self.socket once:@"create_room_error" callback:^(NSArray* data, SocketAckEmitter* ack) {
        if(completion)
            completion(NO, nil);
    }];
}

- (void) handleOnListMessage:(NSArray*) data ack:(SocketAckEmitter*) ack;
{
    NSArray *arr = data[0];
    NSLog(@"received array: %@", arr);
}

- (void) handleOnMessage:(NSArray*) data ack:(SocketAckEmitter*) ack;
{
    NSDictionary *val = data[0][0];
    
    if(val != nil) {
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(onMessageReceive:)]) {
            NSString* messageString = (NSString*)val[@"message"];
            NSDictionary* dict = [Utils dictByJSONString:messageString];
            Message* message = [Message messageWithDictionary:dict];
            [self.delegate onMessageReceive: message];
        }
    }
    
    //NSLog(@"received message: %@", val);
}


@end

