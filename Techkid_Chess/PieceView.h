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

@property const int row;
@property const int column;

@property float width;
@property float height;

- (instancetype) initWithImageName: (NSString*)imgName Piece:(Piece*)piece Width:(float)width Height:(float)height;

- (instancetype) initWithRow: (int)row Column:(int)column Width:(float)width Height:(float)height;

- (instancetype) initWithWidth: (float)width Height:(float)height;
- (void) setPieceAndUpdateBackground: (Piece*)piece;

@end
