//
//  ViewController.m
//  Techkid_Chess
//
//  Created by Ta Hoang Minh on 5/28/16.
//  Copyright © 2016 TechKid. All rights reserved.
//

#import "ViewController.h"
#import "ChatRoomViewController.h"
#import "Board.h"
#import "Piece.h"

#import "PieceView.h"

@interface ViewController ()

@property ChatRoomViewController *socketRoom;
@property int messageIdx;

@property float boardWidth;
@property float boardHeight;

@property float cellWidth;
@property float cellHeight;

@property Board* board;

@property NSMutableDictionary* pieceDictionary;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBoard];
}

- (void) setupBoard; {
    
    self.board = [[Board alloc] init];
    
    [_vBoard layoutIfNeeded];
    
    _boardWidth = _vBoard.bounds.size.width;
    _boardHeight = _vBoard.bounds.size.height;
    _cellWidth = _boardWidth / BOARD_WIDTH;
    _cellHeight = _boardHeight / BOARD_HEIGHT;
    
    self.pieceDictionary = [[NSMutableDictionary alloc] init];

    for(Piece* piece in self.board.pieces) {
        NSString* idString = [piece getIdString];
        PieceView* pieceView = [self createPieceView:[idString stringByAppendingString:@".png"] Piece:piece];
        [self.vBoard addSubview:pieceView];
    }
}

- (PieceView*) createPieceView: (NSString*)imgBundleName Piece:(Piece*) piece {
    
    PieceView* pieceView = [[PieceView alloc] initWithImageName:imgBundleName Piece:piece Width:_cellWidth Height:_cellHeight];
    
    [pieceView updateLocation];
    return pieceView;
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
