//
//  Bishop.m
//  Techkid_Chess
//
//  Created by admin on 5/29/16.
//  Copyright © 2016 TechKid. All rights reserved.
//

#import "Bishop.h"

@implementation Bishop

- (BOOL) checkMoveWithRow:(int)nextRow Column:(int)nextColumn {
    if(![super checkMoveWithRow:nextRow Column:nextColumn]) return NO;
    return [super checkMoveInDiagonalLine:nextRow :nextColumn];
}

- (BOOL) checkMoveWithDeltaX:(int)deltaX deltaY:(int)deltaY; {
    return deltaX == deltaY;
}

@end
