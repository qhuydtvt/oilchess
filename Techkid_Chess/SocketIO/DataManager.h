//
//  DataManager.h
//  AdalBadal
//
//  Created by TaHoangMinh on 5/8/16.
//  Copyright © 2016 DaoVanSon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ChatRoomViewController.h"

@interface DataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property ChatRoomViewController *chatRoomVC;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (void) cleanData;
+ (DataManager *) shareInstance;

@end
