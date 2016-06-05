//
//  Piece.m
//  Techkid_Chess
//
//  Created by admin on 5/29/16.
//  Copyright © 2016 TechKid. All rights reserved.
//

#import "Piece.h"
#import "Board.h"

@implementation Piece

- (instancetype) initWithRow:(int)row Column:(int)column Color:(PieceColor)color;{
    self = [super init];
    if(self) {
        self.row = row;
        self.column = column;
        self.color = color;
    }
    return self;
}

- (BOOL) checkMoveWithRow:(int)nextRow Column:(int)nextColumn; {
    if(nextRow < 0 || nextRow >= BOARD_SIZE) return NO;
    if(nextColumn < 0 || nextColumn >= BOARD_SIZE) return NO;
    if (self != nil && [self.boardProvider respondsToSelector:@selector(getPieceTypeAtRow:Column:)]) {
        PieceColor pieceColorAtNewPosition = [self.boardProvider getPieceTypeAtRow:nextRow Column:nextColumn];
        if (pieceColorAtNewPosition == self.color){
            return NO;
        }
    }
    int deltaX = abs(self.row - nextRow);
    int deltaY = abs(self.column - nextColumn);
    if(deltaX == 0 && deltaY == 0) return NO;
    return [self checkMoveWithDeltaX:deltaX deltaY:deltaY];
}

- (BOOL) checkMoveWithDeltaX:(int)deltaX deltaY:(int)deltaY;{
    return YES;
}

- (void) move: (int)row Column:(int)column; {
    self.row = row;
    self.column = column;
}

- (NSString*) getIdString; {
    NSString* className = NSStringFromClass([self class]);
    NSString* idString = @"";
    if(self.color == PIECE_WHITE) {
        idString = [NSString stringWithFormat:@"%@_white", className];
    }
    if(self.color == PIECE_BLACK) {
        idString = [NSString stringWithFormat:@"%@_black", className];
    }
    
    return [idString lowercaseString];
}

@end
