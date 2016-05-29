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

@implementation Board

- (instancetype)init {
    self = [super init];
    
    if(self) {
        self.pieces = [NSMutableArray array];
        self.pieces = [NSMutableArray array];
        
        King* whiteKing = [[King alloc] initWithRow:0 Column:4 Type:PIECE_WHITE];
        King* blackKing = [[King alloc] initWithRow:7 Column:4 Type:PIECE_BLACK];
        
        Queen* whiteQueen = [[Queen alloc] initWithRow:0 Column:3 Type:PIECE_WHITE];
        Queen* blackQueen = [[Queen alloc] initWithRow:7 Column:3 Type:PIECE_BLACK];
        
        Bishop* whiteBishop1 = [[Bishop alloc] initWithRow:0 Column:2 Type:PIECE_WHITE];
        Bishop* whiteBishop2 = [[Bishop alloc] initWithRow:0 Column:5 Type:PIECE_WHITE];
        
        Bishop* blackBishop1 = [[Bishop alloc] initWithRow:7 Column:2 Type:PIECE_BLACK];
        Bishop* blackBishop2 = [[Bishop alloc] initWithRow:7 Column:5 Type:PIECE_BLACK];
         
        [self.pieces addObject: whiteKing];
        [self.pieces addObject:blackKing];
        [self.pieces addObject: whiteQueen];
        [self.pieces addObject:blackQueen];
        
        [self.pieces addObject:whiteBishop1];
        [self.pieces addObject:whiteBishop2];
        [self.pieces addObject:blackBishop1];
        [self.pieces addObject:blackBishop2];
        
        for (Piece* piece in self.pieces) {
            piece.boardProvider = self;
        }
    }
    return self;
}

- (PieceType) getPieceTypeAtRow: (int)row Column:(int)column; {
    for (Piece* piece in self.pieces) {
        if(piece.row == row && piece.column == column) {
            return piece.type;
        }
    }
    
    return PIECE_NONE;
}
@end
