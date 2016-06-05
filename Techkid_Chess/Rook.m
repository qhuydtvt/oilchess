//
//  Rook.m
//  Techkid_Chess
//
//  Created by admin on 6/4/16.
//  Copyright © 2016 TechKid. All rights reserved.
//

#import "Rook.h"

@implementation Rook

- (BOOL) checkMoveWithDeltaX:(int)deltaX deltaY:(int)deltaY; {
    return deltaX == 0 || deltaY == 0;
}

@end
