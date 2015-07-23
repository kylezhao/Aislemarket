//
//  AMDataManager.h
//  CoreDataFromScratch
//
//  Created by Kyle Zhao on 2015-07-21.
//  Copyright (c) 2015 Kyle Zhao. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

@class AMOProduct;

@interface AMDataManager : NSObject

+ (AMDataManager *)sharedManager;

- (NSFetchedResultsController *)productsFRCForDelegate:(id<NSFetchedResultsControllerDelegate>)delegate;
- (void)loadProducts;

//- (AMOProduct *)insertProductName:(NSString*)name
//                 category:(NSString*)category
//                  barcode:(int16_t)barcode
//                    price:(int16_t)price;

//- (void)deleteAll;

@end
