//
//  ViewController.m
//  Techkid_Chess
//
//  Created by Ta Hoang Minh on 5/28/16.
//  Copyright © 2016 TechKid. All rights reserved.
//

#import "GamePlayViewController.h"
#import "ChatRoomViewController.h"
#import "Board.h"
#import "Piece.h"
#import "Message.h"

#import "PieceView.h"
#import "NetworkConfig.h"

#define TEST_NETWORK 1

typedef enum : NSUInteger {
    PLAY_STATE_IDLE,
    PLAY_STATE_PIECE_SELECTED
} PlayState;

@interface GamePlayViewController ()

@property ChatRoomViewController *socketRoom;
@property int messageIdx;

@property float boardWidth;
@property float boardHeight;

@property float cellWidth;
@property float cellHeight;

@property Board* board;
@property PieceView* selectedView;

@property NSMutableArray* pieceViews;
@property PlayState playState;
@property BOOL moveAllowed;
@property PieceView* selectedPieceView;

@end

@implementation GamePlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.waitIndicator.hidesWhenStopped = YES;
    [self.waitIndicator startAnimating];
    
    [self setupBoard];
    [self setupNetwork];
}

- (void) setupNetwork; {
    self.boardRoom = [[BoardRoom alloc] init];
    self.boardRoom.delegate = self;
    [self.boardRoom startSocket];
}

- (void) reloadBoard; {
    int viewIdx = 0;
    for(int row = 0; row < 8; row++) {
        for(int col = 0; col < 8; col++) {
            PieceView* pieceView = self.pieceViews[viewIdx];
            Piece* piece = [self.board getPieceAtRow:row Column:col];
            [pieceView setPieceAndUpdateBackground:piece];
            viewIdx++;
        }
    }
}

- (void) setupBoard; {
    
    self.playState = PLAY_STATE_IDLE;
    self.selectedPieceView = nil;
    
    self.board = [[Board alloc] init];
    if([[NetworkConfig sharedInstance].userName containsString:@"1"]){
        self.board.currentColor = PIECE_BLACK;
    } else {
        self.board.currentColor = PIECE_WHITE;
    }
    
    [_vBoard layoutIfNeeded];
    self.pieceViews = [NSMutableArray array];
    
    _boardWidth = _vBoard.bounds.size.width;
    _boardHeight = _vBoard.bounds.size.height;
    _cellWidth = _boardWidth / BOARD_WIDTH;
    _cellHeight = _boardHeight / BOARD_HEIGHT;
    
    for(int row = 0; row < 8; row++) {
        for(int col = 0; col < 8; col++) {
            PieceView* pieceView = [[PieceView alloc] initWithRow:row Column:col Width:self.cellWidth Height:self.cellHeight];
            [self.vBoard addSubview:pieceView];
            [self.pieceViews addObject:pieceView];
            [pieceView layoutIfNeeded];
            [pieceView addTarget:self action:@selector(onPieceTap:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    [self reloadBoard];
}

- (void) onPieceTap: (UIButton *) p; {
    PieceView* pieceView = (PieceView*)p;
    
    NSLog(@"%@", [pieceView.piece getIdString]);

    switch (self.playState) {
        case PLAY_STATE_IDLE:
#if TEST_NETWORK
            if(pieceView.piece != nil)
#else
            if(pieceView.piece != nil && pieceView.piece.color == self.board.currentColor)
#endif
            {
                pieceView.selected = YES;
                self.playState = PLAY_STATE_PIECE_SELECTED;
                self.selectedPieceView = pieceView;
            }
            break;
        case PLAY_STATE_PIECE_SELECTED:
            if(pieceView.piece != nil) {
                pieceView.selected = YES;
                self.selectedPieceView = pieceView;
            } else {
                Piece* selectedPiece = self.selectedPieceView.piece;
                int row = pieceView.row;
                int column = pieceView.column;
                
                if([selectedPiece checkMoveWithRow:pieceView.row Column:pieceView.column]) {
                    Message* message = [[Message alloc] initWithSourceRow:selectedPiece.row :selectedPiece.column :row :column :[selectedPiece getIdString]];
                    [self.boardRoom sendMessage:message];
//                    [selectedPiece move:row Column:column];
                    [self reloadBoard];
                    self.playState = PLAY_STATE_IDLE;
                }
            }
            break;
        default:
            break;
    }
}


- (void) onRoomReady; {
    [self.waitIndicator stopAnimating];
}

- (void) onMessageReceive: (Message*)message; {
    NSLog(@"Message received: %@", message);
    [self.board moveByMessage:message];
    [self reloadBoard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
