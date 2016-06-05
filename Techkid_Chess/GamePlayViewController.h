//
//  ViewController.h
//  Techkid_Chess
//
//  Created by Ta Hoang Minh on 5/28/16.
//  Copyright © 2016 TechKid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoardRoom.h"

@interface GamePlayViewController : UIViewController <BoardRoomDelegate>

@property (weak, nonatomic) IBOutlet UIView *vBoard;
@property BoardRoom* boardRoom;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *waitIndicator;

@end

