//
//  ChatRoomViewController.h
//  AdalBadal
//
//  Created by TaHoangMinh on 5/8/16.
//  Copyright © 2016 DaoVanSon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Techkid_Chess-Swift.h>

@interface ChatRoomViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property SocketIOClient* socket;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSString *userName;
@property NSString *roomName;

@property BOOL roomReady;

- (void) createRoom:(NSString *)roomName userId:(NSArray *)arrUserId complete:(void(^)(BOOL result, NSString *roomName)) completion;
- (void) startChatWithRoom:(NSString *)roomName;
- (void) startSocket;
- (instancetype)initWithUserName:(NSString *)username room:(NSString *)roomName;

@end
