//
//  ViewController.h
//  Techkid_Chess
//
//  Created by Ta Hoang Minh on 5/28/16.
//  Copyright © 2016 TechKid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoardRoom.h"
#import "Board.h"

@interface GamePlayViewController : UIViewController <BoardRoomDelegate, BoardDelegate>

@property (weak, nonatomic) IBOutlet UIView *vBoard;
@property (weak, nonatomic) IBOutlet UILabel *lblGameState;
@property BoardRoom* boardRoom;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *waitIndicator;

@end

