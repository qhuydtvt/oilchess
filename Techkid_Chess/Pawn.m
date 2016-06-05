//
//  Pawn.m
//  Techkid_Chess
//
//  Created by admin on 6/4/16.
//  Copyright © 2016 TechKid. All rights reserved.
//

#import "Pawn.h"

@interface Pawn()

@end

@implementation Pawn

- (instancetype)initWithRow:(int)row Column:(int)column Color:(PieceColor)color {
    self = [super initWithRow:row Column:column Color:color];
    
    if(self) {
        self.firstMove = YES;
    }
    return self;
}

- (BOOL)checkMoveWithRow:(int)nextRow Column:(int)nextColumn; {
    
    if(![super checkMoveWithRow:nextRow Column:nextColumn]) return NO;
    int dr = self.row - nextRow;
    int dc = self.column - nextColumn;
        int range = 1;
    if(self.firstMove) range = 2;
    
    if(dc != 0) return NO;
    if(self.color == PIECE_BLACK && dr < 0) return NO;
    if(self.color == PIECE_WHITE && dr > 0) return NO;
    return abs(dr) <= range;
}

- (void)move:(int)row Column:(int)column; {
    [super move:row Column:column];
    if(self.firstMove) self.firstMove = NO;
}

@end
