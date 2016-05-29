//
//  Piece.h
//  Techkid_Chess
//
//  Created by admin on 5/29/16.
//  Copyright © 2016 TechKid. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum PieceType {
    PIECE_BLACK,
    PIECE_WHITE,
    PIECE_NONE
} PieceType;

@protocol BoardProvider <NSObject>

- (PieceType) getPieceTypeAtRow: (int)row Column:(int)column;

@end

@interface Piece : NSObject

@property int row;
@property int column;
@property PieceType type;

@property id<BoardProvider> boardProvider;

- (BOOL) checkMoveWithRow: (int)nextRow Column:(int)nextColumn;

- (NSString*) getIdString;

- (instancetype) initWithRow:(int)row Column:(int)column  Type:(PieceType)type;

@end
