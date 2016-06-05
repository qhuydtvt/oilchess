//
//  Piece.h
//  Techkid_Chess
//
//  Created by admin on 5/29/16.
//  Copyright © 2016 TechKid. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum PieceColor {
    PIECE_BLACK,
    PIECE_WHITE,
    PIECE_NONE
} PieceColor;

@protocol BoardProvider <NSObject>

- (PieceColor) getPieceTypeAtRow: (int)row Column:(int)column;

@end

@interface Piece : NSObject

@property int row;
@property int column;
@property PieceColor color;

@property id<BoardProvider> boardProvider;

- (BOOL) checkMoveWithRow: (int)nextRow Column:(int)nextColumn;

- (BOOL) checkMoveWithDeltaX: (int)deltaX deltaY:(int)deltaY;

- (void) move: (int)row Column:(int)column;

- (NSString*) getIdString;

- (instancetype) initWithRow:(int)row Column:(int)column  Color:(PieceColor)color;
@end
