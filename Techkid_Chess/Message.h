//
//  Message.h
//  Techkid_Chess
//
//  Created by admin on 6/5/16.
//  Copyright © 2016 TechKid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Piece.h"

@interface Message : NSObject

@property int sourceRow;
@property int sourceColumn;

@property int destinationRow;
@property int destinationColumn;

@property NSString* idString;

- (instancetype) initWithSourceRow: (int)sourceRow :(int)sourceColumn :(int)destinationRow :(int)destinationColumn :(NSString*)idString;

- (NSDictionary*) getMessageData;

+ (Message*) messageWithDictionary: (NSDictionary *)dictionary;

@end
