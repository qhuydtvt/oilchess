//
//  King.m
//  Techkid_Chess
//
//  Created by admin on 5/29/16.
//  Copyright © 2016 TechKid. All rights reserved.
//

#import "King.h"

@implementation King

- (BOOL) checkMoveWithDeltaX:(int)deltaX deltaY:(int)deltaY; {
    if(deltaX < 2 && deltaY < 2) return YES;
    return NO;
}

@end
