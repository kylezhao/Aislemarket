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

@interface AMDataManager : NSObject

@property (nonatomic, strong) AMOUser *currentUser;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

+ (AMDataManager *)sharedManager;
- (NSFetchedResultsController *)productsFRCForDelegate:(id<NSFetchedResultsControllerDelegate>)delegate;
- (NSFetchedResultsController *)shoppingListsFRCForDelegate:(id<NSFetchedResultsControllerDelegate>)delegate;
- (void)loginUsername:(NSString *)username password:(NSString *)password handler:(void (^)(BOOL succsess, NSError **error))handler;
- (void)loadOrders;
- (void)loadProducts;
- (void)loadShopplingLists;
- (void)clearCoreData;

@end
/*
- (AMOProduct *)insertProductName:(NSString*)name
                 category:(NSString*)category
                  barcode:(int16_t)barcode
                    price:(int16_t)price;
- (void)deleteAll;
*/
