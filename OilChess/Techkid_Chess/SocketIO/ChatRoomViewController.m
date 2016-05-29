//
//  ChatRoomViewController.m
//  AdalBadal
//
//  Created by TaHoangMinh on 5/8/16.
//  Copyright © 2016 DaoVanSon. All rights reserved.
//

#import "ChatRoomViewController.h"

@interface ChatRoomViewController ()

@end

@implementation ChatRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (instancetype)initWithUserName:(NSString *)username room:(NSString *)roomName;
{
    self = [super init];
    if (self) {
        self.userName = username;
        self.roomName = roomName;
    }
    return self;
}

- (void) startSocket;
{
    NSURL* url = [[NSURL alloc] initWithString:@"http://45.32.247.228:3015"];
    
    self.socket = [[SocketIOClient alloc] initWithSocketURL:url options:@{@"log": @YES, @"forcePolling": @YES}];
    
    [self.socket on:@"connect" callback:^(NSArray* data, SocketAckEmitter* ack) {
        NSLog(@"socket connected");
        [self.socket emit:@"user_id" withItems:@[self.userName]];
        [self createRoom:self.roomName userId:@[self.userName] complete:^(BOOL result, NSString *roomName) {
            if (result) {
                self.roomReady = YES;
            }
        }];
    }];
    
    [self.socket on:@"room_result" callback:^(NSArray* data, SocketAckEmitter* ack) {
        self.roomReady = YES;
    }];
    
    [self.socket on:@"message" callback:^(NSArray* data, SocketAckEmitter* ack) {
        [self handleOnMessage:data ack:ack];
    }];
    
    // Do any additional setup after loading the view, typically from a nib.
    [self.socket emit:@"list_message" withItems:@[@"0", @"1000000", self.roomName]];
    [self.socket on:@"list_message_result" callback:^(NSArray* data, SocketAckEmitter* ack) {
        [self handleOnListMessage:data ack:ack];
    }];
    
    [self.socket connect];
}


- (void) createRoom:(NSString *)roomName userId:(NSArray *)arrUserId complete:(void(^)(BOOL result, NSString *roomName)) completion;
{
    NSString *strUserId = [arrUserId componentsJoinedByString:@";"];
    [self.socket emit:@"create_room" withItems:@[roomName, strUserId]];
    [self.socket once:@"create_room_success" callback:^(NSArray* data, SocketAckEmitter* ack) {
        [self.socket emit:@"join_room" withItems:@[data[0]]];
        completion(YES, data[0]);
    }];
    
    [self.socket once:@"create_room_error" callback:^(NSArray* data, SocketAckEmitter* ack) {
        completion(NO, nil);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    UILabel *lblUser = (UILabel *)[cell.contentView viewWithTag:101];
    UILabel *lblMessage = (UILabel *)[cell.contentView viewWithTag:102];
    
    lblUser.text = @"1";
    lblMessage.text = @"1\n2";
    
    return cell;
}

- (void) handleOnListMessage:(NSArray*) data ack:(SocketAckEmitter*) ack;
{
    NSArray *arr = data[0];
    NSLog(@"received array: %@", arr);
}

- (void) handleOnMessage:(NSArray*) data ack:(SocketAckEmitter*) ack;
{
    NSDictionary *val = data[0][0];
    NSLog(@"received message: %@", val);
}

@end
