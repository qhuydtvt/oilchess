//
//  Board.h
//  Techkid_Chess
//
//  Created by admin on 5/29/16.
//  Copyright © 2016 TechKid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Piece.h"
#import "Message.h"

#define BOARD_SIZE 64
#define BOARD_WIDTH 8
#define BOARD_HEIGHT 8


@protocol BoardDelegate <NSObject>

@required
- (void) gameDidFinish: (PieceColor)loser;

@end

@interface Board : NSObject <BoardProvider>

@property NSMutableArray* pieces;
@property BOOL isBlackTurn;
@property id<BoardDelegate> delegate;
@property BOOL gameFinished;

- (Piece*) getPieceAtRow: (int)row Column:(int)column;

- (BOOL) moveByMessage: (Message *)message;
- (BOOL) moveAllowed: (PieceColor)pieceColor;

@end

