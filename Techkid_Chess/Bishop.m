//
//  Bishop.m
//  Techkid_Chess
//
//  Created by admin on 5/29/16.
//  Copyright © 2016 TechKid. All rights reserved.
//

#import "Bishop.h"

@implementation Bishop

- (BOOL)checkMoveWithRow:(int)nextRow Column:(int)nextColumn{
    if([super checkMoveWithRow:nextRow Column:nextColumn]) {
        int dr = abs(nextRow - self.row);
        int dc = abs(nextColumn - self.column);
        if(dc == dr) return YES;
        return NO;
    }
    return NO;
}

@end
