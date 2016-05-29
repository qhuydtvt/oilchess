//
//  PieceView.m
//  Techkid_Chess
//
//  Created by admin on 5/29/16.
//  Copyright © 2016 TechKid. All rights reserved.
//

#import "PieceView.h"
#import <UIKit/UIKit.h>

@implementation PieceView

- (instancetype) initWithImageName: (NSString*)imgName Piece:(Piece*)piece Width:(float)width Height:(float)height; {
    
    self = [super init];
    if(self) {
        [self setBackgroundImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.translatesAutoresizingMaskIntoConstraints = YES;
        self.width = width;
        self.height = height;
        self.piece = piece;
    }
    return self;
}

- (void) updateLocation {
    self.frame = CGRectMake(_piece.column * _width, _piece.row * _height, _width, _height);
}

@end
