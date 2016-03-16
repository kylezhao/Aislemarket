//
//  AMDataManager.h
//  CoreDataFromScratch
//
//  Created by Kyle Zhao on 2015-07-21.
//  Copyright (c) 2015 Kyle Zhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreData;
@class AMOUser;
@class AMOProduct;
@class AMOShoppingList;

@interface AMDataManager : NSObject

@property (nonatomic, strong) AMOUser *currentUser;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

+ (AMDataManager *)sharedManager;
- (NSFetchedResultsController *)productsFRCForDelegate:(id<NSFetchedResultsControllerDelegate>)delegate;
- (NSFetchedResultsController *)shoppingListsFRCForDelegate:(id<NSFetchedResultsControllerDelegate>)delegate;
- (void)requestLogin:(NSString *)username password:(NSString *)password handler:(void (^)(BOOL))handler;
- (void)requestProductsHandler:(void (^)(BOOL))handler;
- (void)requestInventoryHandler:(void (^)(BOOL))handler;
- (void)requestListsHandler:(void (^)(BOOL))handler;
- (void)requestCreateList:(NSString *)name handler:(void (^)(BOOL))handler;
- (void)requestUpdateList:(AMOShoppingList *)shoppingList newName:(NSString *)newName handler:(void (^)(BOOL))handler;
- (void)requestSatisfaction:(BOOL)sat product:(AMOProduct *)product handler:(void (^)(BOOL))handler;
- (void)clearCoreData;
- (void)saveContext;
@end
/*
- (AMOProduct *)insertProductName:(NSString*)name
                 category:(NSString*)category
                  barcode:(int16_t)barcode
                    price:(int16_t)price;
- (void)deleteAll;
*/
