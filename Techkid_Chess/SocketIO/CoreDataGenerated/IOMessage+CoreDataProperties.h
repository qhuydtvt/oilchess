//
//  IOMessage+CoreDataProperties.h
//  
//
//  Created by TaHoangMinh on 5/8/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "IOMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface IOMessage (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSString *room_id;
@property (nullable, nonatomic, retain) NSString *message;
@property (nullable, nonatomic, retain) NSString *create_time;
@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) NSNumber *owner_id;

@end

NS_ASSUME_NONNULL_END
