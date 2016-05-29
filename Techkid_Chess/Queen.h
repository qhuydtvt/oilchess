//
//  Queen.h
//  Techkid_Chess
//
//  Created by admin on 5/29/16.
//  Copyright © 2016 TechKid. All rights reserved.
//

#import "Piece.h"

@interface Queen : Piece

- (instancetype) initWithRow:(int)row Column:(int)column Type:(PieceType)type;

@end
