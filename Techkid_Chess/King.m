//
//  King.m
//  Techkid_Chess
//
//  Created by admin on 5/29/16.
//  Copyright © 2016 TechKid. All rights reserved.
//

#import "King.h"

@implementation King

- (BOOL) checkMoveWithRow:(int)nextRow Column:(int)nextColumn; {
    if([super checkMoveWithRow:nextRow Column:nextColumn]) {
        const int dr = abs(nextRow - self.row);
        const int dc = abs(nextColumn - self.column);
        if(dr == 0 && dc == 1 ) return YES;
        if(dr == 1 && dc == 0) return YES;
        return NO;
    }
    
    return NO;
}

@end
