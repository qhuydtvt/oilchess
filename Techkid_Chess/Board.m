//
//  Board.m
//  Techkid_Chess
//
//  Created by admin on 5/29/16.
//  Copyright © 2016 TechKid. All rights reserved.
//

#import "Board.h"
#import "King.h"
#import "Queen.h"
#import "Bishop.h"
#import "Knight.h"
#import "Rook.h"
#import "Pawn.h"

@implementation Board

- (instancetype)init {
    self = [super init];
    
    if(self) {
        self.pieces = [NSMutableArray array];
        self.pieces = [NSMutableArray array];
        
        King* whiteKing = [[King alloc] initWithRow:0 Column:4 Color:PIECE_WHITE];
        King* blackKing = [[King alloc] initWithRow:7 Column:4 Color:PIECE_BLACK];
        
        Queen* whiteQueen = [[Queen alloc] initWithRow:0 Column:3 Color:PIECE_WHITE];
        Queen* blackQueen = [[Queen alloc] initWithRow:7 Column:3 Color:PIECE_BLACK];
        
        Bishop* whiteBishop1 = [[Bishop alloc] initWithRow:0 Column:2 Color:PIECE_WHITE];
        Bishop* whiteBishop2 = [[Bishop alloc] initWithRow:0 Column:5 Color:PIECE_WHITE];
        
        Bishop* blackBishop1 = [[Bishop alloc] initWithRow:7 Column:2 Color:PIECE_BLACK];
        Bishop* blackBishop2 = [[Bishop alloc] initWithRow:7 Column:5 Color:PIECE_BLACK];
        
        Knight* whiteKnight1 = [[Knight alloc] initWithRow:0 Column:1 Color:PIECE_WHITE];
        Knight* whiteKnight2 = [[Knight alloc] initWithRow:0 Column:6 Color:PIECE_WHITE];
        
        Knight* blackKnight1 = [[Knight alloc] initWithRow:7 Column:1 Color:PIECE_BLACK];
        Knight* blackKnight2 = [[Knight alloc] initWithRow:7 Column:6 Color:PIECE_BLACK];
        
        Rook* whiteRook1 = [[Rook alloc] initWithRow:0 Column:0 Color:PIECE_WHITE];
        Rook* whiteRook2 = [[Rook alloc] initWithRow:0 Column:7 Color:PIECE_WHITE];
        
        Rook* blackRook1 = [[Rook alloc] initWithRow:7 Column:0 Color:PIECE_BLACK];
        Rook* blackRook2 = [[Rook alloc] initWithRow:7 Column:7 Color:PIECE_BLACK];
        
        [self.pieces addObject: whiteKing];
        [self.pieces addObject:blackKing];
        [self.pieces addObject: whiteQueen];
        [self.pieces addObject:blackQueen];
        
        [self.pieces addObject:whiteBishop1];
        [self.pieces addObject:whiteBishop2];
        [self.pieces addObject:blackBishop1];
        [self.pieces addObject:blackBishop2];
        
        [self.pieces addObject:whiteKnight1];
        [self.pieces addObject:whiteKnight2];
        [self.pieces addObject:blackKnight1];
        [self.pieces addObject:blackKnight2];
        
        [self.pieces addObject:whiteRook1];
        [self.pieces addObject:whiteRook2];
        [self.pieces addObject:blackRook1];
        [self.pieces addObject:blackRook2];

        
        for (int column = 0; column < BOARD_WIDTH; column++) {
            Pawn* whitePawn = [[Pawn alloc] initWithRow:1 Column:column Color:PIECE_WHITE];
            Pawn* blackPawn = [[Pawn alloc] initWithRow:6 Column:column Color:PIECE_BLACK];
            [self.pieces addObject:whitePawn];
            [self.pieces addObject:blackPawn];
        }
              
        for (Piece* piece in self.pieces) {
            piece.boardProvider = self;
        }
        
        self.isBlackTurn = YES;
        self.gameFinished = NO;
    }
    return self;
}

- (PieceColor) getPieceTypeAtRow: (int)row Column:(int)column; {
    for (Piece* piece in self.pieces) {
        if(piece.row == row && piece.column == column) {
            return piece.color;
        }
    }
    
    return PIECE_NONE;
}

- (Piece *)getPieceAtRow:(int)row Column:(int)column; {
    for (Piece* piece in self.pieces) {
        if(piece.row == row && piece.column == column) {
            return piece;
        }
    }
    return nil;
}

- (BOOL) moveByMessage: (Message *)message; {
    
    Piece* piece = [self getPieceAtRow:message.sourceRow Column:message.sourceColumn];
    if(piece == nil) return NO;
    if(![[piece getIdString] isEqualToString:message.idString]) return NO;
    if(piece.color == PIECE_BLACK && !self.isBlackTurn)  return NO;
    if(piece.color == PIECE_WHITE && self.isBlackTurn) return NO;
    if(![piece checkMoveWithRow:message.destinationRow Column:message.destinationColumn]) return NO;
    
    Piece* pieceAtNextPosition = [self getPieceAtRow:message.destinationRow Column:message.destinationColumn];
    if(pieceAtNextPosition) {
        [self.pieces removeObject:pieceAtNextPosition];
        if([pieceAtNextPosition isKindOfClass:[King class]]) {
            /* We have a winner */
            self.gameFinished = YES;
            if(self.delegate != nil && [self.delegate respondsToSelector:@selector(gameDidFinish:)]) {
                [self.delegate gameDidFinish:pieceAtNextPosition.color];
            }
        }
    }
    
    piece.row = message.destinationRow;
    piece.column = message.destinationColumn;
    
    self.isBlackTurn = !self.isBlackTurn;
    return YES;
}


- (BOOL) moveAllowed: (PieceColor)pieceColor; {
    if (self.gameFinished) return NO;
    if(self.isBlackTurn) return pieceColor == PIECE_BLACK;
    else return pieceColor == PIECE_WHITE;
}

@end
