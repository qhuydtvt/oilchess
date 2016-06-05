//
//  ChatRoom.h
//  Techkid_Chess
//
//  Created by admin on 5/29/16.
//  Copyright © 2016 TechKid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message.h"

@protocol BoardRoomDelegate <NSObject>

@required
- (void) onRoomReady;
- (void) onMessageReceive: (Message*)message;

@end

@interface BoardRoom : NSObject

- (instancetype)init;
- (void) startSocket;
- (BOOL) sendMessage: (Message*) message;
- (void) createRoom:(NSString *)roomName userId:(NSArray *)arrUserId complete:(void(^)(BOOL result, NSString *roomName)) completion;

@property id<BoardRoomDelegate> delegate;

@end
