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

- (instancetype) initWithRow:(int)row Column:(int)column  Type:(PieceType)type;{
    self = [super init];
    if(self) {
        self.row = row;
        self.column = column;
        self.type = type;
    }
    return self;
}

- (BOOL) checkMoveWithRow:(int)nextRow Column:(int)nextColumn; {
    if(nextRow < 0 || nextRow >= BOARD_SIZE) return NO;
    if(nextColumn < 0 || nextColumn >= BOARD_SIZE) return NO;
    if (self != nil && [self.boardProvider respondsToSelector:@selector(getPieceTypeAtRow)]) {
        PieceType pieceTypeAtNewPosition = [self.boardProvider getPieceTypeAtRow:nextRow Column:nextColumn];
        if (pieceTypeAtNewPosition == self.type){
            return NO;
        }
    }
    return YES;
}

- (NSString*) getIdString; {
    NSString* className = NSStringFromClass([self class]);
    NSString* idString = @"";
    if(self.type == PIECE_WHITE) {
        idString = [NSString stringWithFormat:@"%@_white", className];
    }
    if(self.type == PIECE_BLACK) {
        idString = [NSString stringWithFormat:@"%@_black", className];
    }
    
    return [idString lowercaseString];
}

@end
