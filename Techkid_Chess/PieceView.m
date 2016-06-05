//
//  PieceView.m
//  Techkid_Chess
//
//  Created by admin on 5/29/16.
//  Copyright © 2016 TechKid. All rights reserved.
//

#import "PieceView.h"
#import "Board.h"
#import <UIKit/UIKit.h>

@implementation PieceView

- (instancetype) initWithImageName: (NSString*)imgName Piece:(Piece*)piece Width:(float)width Height:(float)height; {
    
    self = [super init];
    if(self) {
        [self setBackgroundImage:[UIImage imageNamed:imgName]		 forState:UIControlStateNormal];
        
        UIImage *newImage = [UIImage imageNamed:imgName];
        newImage = [self image:newImage byApplyingAlpha:0.5];
        
        
        [self setBackgroundImage:newImage forState:UIControlStateSelected];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.translatesAutoresizingMaskIntoConstraints = YES;
        self.width = width;
        self.height = height;
        self.piece = piece;
    }
    return self;
}

- (instancetype) initWithRow: (int)row Column:(int)column Width:(float)width Height:(float)height Rotate:(BOOL)rotate; {
    
    self = [super init];
    
    if(self) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.translatesAutoresizingMaskIntoConstraints = YES;
        self.rotate = rotate;
        self.row = row;
        self.column = column;
        if(self.rotate) {
            self.frame = CGRectMake((BOARD_WIDTH - 1 - column) * width, (BOARD_HEIGHT - 1 - row) * height, width, height);
        }
        else {
            self.frame = CGRectMake(column * width, row * height, width, height);
        }
    }
    
    return self;
}

- (instancetype) initWithWidth: (float)width Height:(float)height; {
    self = [super init];
    
    if(self) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.translatesAutoresizingMaskIntoConstraints = YES;
        self.width = width;
        self.height = height;
    }
    
    return self;
}

- (UIImage *)image:(UIImage *)img byApplyingAlpha:(CGFloat) alpha {
    UIGraphicsBeginImageContextWithOptions(img.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, img.size.width, img.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, img.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void) setPieceAndUpdateBackground: (Piece*)piece; {
    self.piece = piece;
    if(self.piece != nil) {
        NSString* idString = [self.piece getIdString];
        NSString* bundleImgName = [idString stringByAppendingString:@".png"];
        [self setBackgroundImage:[UIImage imageNamed:bundleImgName] forState:UIControlStateNormal];
    } else {
        [self setBackgroundImage:nil forState:UIControlStateNormal];
    }
}

- (void) updateLocation {
    self.frame = CGRectMake(_piece.column * _width, _piece.row * _height, _width, _height);
}

@end
