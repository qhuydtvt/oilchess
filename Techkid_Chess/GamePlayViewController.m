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

#define TEST_NETWORK 0

typedef enum : NSUInteger {
    PLAY_STATE_IDLE,
    PLAY_STATE_PIECE_SELECTED
} PlayState;

typedef enum : NSUInteger {
    GAME_STATE_PLAYING,
    GAME_STATE_WON,
    GAME_STATE_LOST
} GameState;

@interface GamePlayViewController ()

@property ChatRoomViewController *socketRoom;
@property int messageIdx;

@property float boardWidth;
@property float boardHeight;

@property float cellWidth;
@property float cellHeight;

@property PieceColor playerColor;
@property Board* board;
@property PieceView* selectedView;

@property NSMutableArray* pieceViews;
@property PlayState playState;
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

- (PieceView*) getPieceViewByRow: (int)row :(int)col {
    int idx = row * BOARD_HEIGHT + col;
    PieceView* pieceView = self.pieceViews[idx];
    return pieceView;
}

- (void) enableDisableAllPieceViews: (BOOL)isEnabled {
    for(PieceView* pieceVew in self.pieceViews) {
        [pieceVew setEnabled:isEnabled];
    }
}

- (void) setupBoard; {
    
    self.playState = PLAY_STATE_IDLE;
    self.selectedPieceView = nil;
    [self updateGameState:GAME_STATE_PLAYING];
    
    self.board = [[Board alloc] init];
    self.board.delegate = self;
    if([[NetworkConfig sharedInstance].userName containsString:@"1"]){
        self.playerColor = PIECE_BLACK;
    } else {
        self.playerColor = PIECE_WHITE;
    }
    
    [_vBoard layoutIfNeeded];
    self.pieceViews = [NSMutableArray array];
    
    _boardWidth = _vBoard.bounds.size.width;
    _boardHeight = _vBoard.bounds.size.height;
    _cellWidth = _boardWidth / BOARD_WIDTH;
    _cellHeight = _boardHeight / BOARD_HEIGHT;
    
    BOOL rotate = (self.playerColor == PIECE_WHITE);
    
    for(int row = 0; row < 8; row++) {
        for(int col = 0; col < 8; col++) {
            PieceView* pieceView = [[PieceView alloc] initWithRow:row Column:col Width:self.cellWidth Height:self.cellHeight Rotate:(BOOL)rotate];
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
                if (pieceView.piece != nil &&
                    pieceView.piece.color == self.playerColor &&
                    [self.board moveAllowed:self.playerColor]
                    )
#endif
                {
                    pieceView.selected = YES;
                    self.playState = PLAY_STATE_PIECE_SELECTED;
                    self.selectedPieceView = pieceView;
                }
            break;
        case PLAY_STATE_PIECE_SELECTED:
            if(pieceView.piece != nil && pieceView.piece.color == self.selectedPieceView.piece.color) {
                self.selectedPieceView = pieceView;
            } else {
                Piece* selectedPiece = self.selectedPieceView.piece;
                int row = pieceView.row;
                int column = pieceView.column;
                
                if([selectedPiece checkMoveWithRow:pieceView.row Column:pieceView.column]) {
                    [self enableDisableAllPieceViews: NO];
                    Message* message = [[Message alloc] initWithSourceRow:selectedPiece.row :selectedPiece.column :row :column :[selectedPiece getIdString]];
                    [self.boardRoom sendMessage:message];
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
    PieceView* srcPieceView = [self getPieceViewByRow:message.sourceRow :message.sourceColumn];
    PieceView* dstPieceView = [self getPieceViewByRow:message.destinationRow :message.destinationColumn];
    if(srcPieceView.piece != nil) {
        CGPoint oldCenter = srcPieceView.center;
        [UIView animateWithDuration:0.3f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveLinear
         
                         animations:^{
                             srcPieceView.center = dstPieceView.center;
                         }
                         completion:^(BOOL finished) {
                             srcPieceView.center = oldCenter;
                             [self.board moveByMessage:message];
                             [self reloadBoard];
                             [self enableDisableAllPieceViews:YES];
                         }];
    }
    
    
}

#pragma MARK BoardDelegate

- (void) gameDidFinish: (PieceColor)loser; {
    if(loser == self.playerColor) {
        [self updateGameState:GAME_STATE_LOST];
    } else {
        [self updateGameState:GAME_STATE_WON];
    }
}

- (void) updateGameState: (GameState)gameState {
    switch (gameState) {
        case GAME_STATE_WON:
            [self.lblGameState setHidden:NO];
            [self.lblGameState setText:@"YOU WON!!!"];
            [self.lblGameState setTextColor:[UIColor greenColor]];
            break;
        case GAME_STATE_LOST:
            [self.lblGameState setHidden:NO];
            [self.lblGameState setText:@"YOU LOST!!!"];
            [self.lblGameState setTextColor:[UIColor redColor]];
            break;
        case GAME_STATE_PLAYING:
            [self.lblGameState setHidden:YES];
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
