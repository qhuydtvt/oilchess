//
//  ViewController.m
//  Techkid_Chess
//
//  Created by Ta Hoang Minh on 5/28/16.
//  Copyright © 2016 TechKid. All rights reserved.
//

#import "ViewController.h"
#import "ChatRoomViewController.h"
@interface ViewController ()

@property ChatRoomViewController *socketRoom;
@property int messageIdx;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.socketRoom = [[ChatRoomViewController alloc] initWithUserName:@"69" room:@"tbl_oilchess_69"];
    [self.socketRoom startSocket];
    
    [self sendMessage:@"first message"];
    self.messageIdx = 0;
}

- (void) sendMessage:(NSString *)message
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.socketRoom.roomReady) {
            [self.socketRoom.socket emit:@"message" withItems:@[message, self.socketRoom.roomName, self.socketRoom.userName]];
        }
        [self sendMessage:[NSString stringWithFormat:@"message %d", self.messageIdx++]];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    
}

@end
