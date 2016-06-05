//
//  Queen.m
//  Techkid_Chess
//
//  Created by admin on 5/29/16.
//  Copyright © 2016 TechKid. All rights reserved.
//

#import "Queen.h"

@implementation Queen

- (BOOL) checkMoveWithRow:(int)nextRow Column:(int)nextColumn; {
    if(![super checkMoveWithRow:nextRow Column:nextColumn]) return NO;
    if(self.row == nextRow || self.column == nextColumn) {
        return [self checkMoveInStraightLine:nextRow :nextColumn];
    } else {
        return [self checkMoveInDiagonalLine:nextRow :nextColumn];
    }
    
}

- (BOOL) checkMoveWithDeltaX:(int)deltaX deltaY:(int)deltaY; {
    return (deltaX == 0 || deltaY == 0 || (deltaX == deltaY));
}

@end
