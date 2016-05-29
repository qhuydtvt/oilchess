//
//  ChatRoom.h
//  Techkid_Chess
//
//  Created by admin on 5/29/16.
//  Copyright © 2016 TechKid. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BoardRoomDelegate <NSObject>

@required
- (void) onRoomReady;
- (void) onMessageReceive: (NSDictionary*)data;

@end

@interface BoardRoom : NSObject

- (instancetype)init;
- (void) startSocket;
- (void) sendMessage: (NSDictionary*)data;

@property id<BoardRoomDelegate> delegate;

@end
