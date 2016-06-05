//
//  Message.m
//  Techkid_Chess
//
//  Created by admin on 6/5/16.
//  Copyright © 2016 TechKid. All rights reserved.
//

#import "Message.h"

@implementation Message

+ (NSDictionary*) buildMessage: (int)sourceRow SourceColumn:(int)sourceColumn DestinationRow:(int)destRow DestinationColumn:(int)destCol PieceType:(NSString*)pieceType Color:(BOOL)color; {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithLong:sourceRow], @"src_row",
            [NSNumber numberWithInt:sourceColumn], "@src_col",
            [NSNumber numberWithInt:destRow], @"dest_row",
            [NSNumber numberWithInt:destCol], @"dest_col",
            pieceType, @"piece_type",
            [NSNumber numberWithInt:color], @"piece_color",
            nil];
}

- (instancetype) initWithSourceRow: (int)sourceRow :(int)sourceColumn :(int)destinationRow :(int)destinationColumn :(NSString*)idString {
    self = [super init];
    
    if(self) {
        self.sourceRow = sourceRow;
        self.sourceColumn = sourceColumn;
        self.destinationRow = destinationRow;
        self.destinationColumn = destinationColumn;
        self.idString = idString;
    }
    
    return self;
}

- (NSDictionary*) getMessageData; {
    return [[NSDictionary alloc] initWithObjectsAndKeys:
                          [NSNumber numberWithInt:self.sourceRow], @"src_row",
                          [NSNumber numberWithInt:self.sourceColumn], @"src_col",
                          [NSNumber numberWithInt:self.destinationRow], @"dest_row",
                          [NSNumber numberWithInt:self.destinationColumn], @"dest_col",
                          self.idString, @"id_string",
                          nil];
}

+ (Message*) messageWithDictionary: (NSDictionary *)dictionary; {
    Message* message = [[Message alloc] initWithSourceRow
                        :((NSNumber*)dictionary[@"src_row"]).intValue
                        :((NSNumber*)dictionary[@"src_col"]).intValue
                        :((NSNumber*)dictionary[@"dest_row"]).intValue
                        :((NSNumber*)dictionary[@"dest_col"]).intValue
                        :(NSString*)dictionary[@"id_string"]];
    return message;
}

@end
