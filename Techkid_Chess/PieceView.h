//
//  PieceView.h
//  Techkid_Chess
//
//  Created by admin on 5/29/16.
//  Copyright © 2016 TechKid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Piece.h"

@interface PieceView : UIButton

@property Piece* piece;
@property float width;
@property float height;

- (instancetype) initWithImageName: (NSString*)imgName Piece:(Piece*)piece Width:(float)width Height:(float)height;

- (void) updateLocation;

@end
