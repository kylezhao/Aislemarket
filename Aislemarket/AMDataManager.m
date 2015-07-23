//
//  AMDataManager.m
//  CoreDataFromScratch
//
//  Created by Kyle Zhao on 2015-07-21.
//  Copyright (c) 2015 Kyle Zhao. All rights reserved.
//

#import "AMDataManager.h"
#import "AMOProduct.h"
#import <RestKit/RestKit.h>


static NSString * const kRestEndpointURL = @"http://104.236.229.162:8080";
static NSString * const kProductsPath = @"/simple-service-webapp/webapi/products/1";

@implementation AMDataManager {
    NSManagedObjectContext *_managedObjectContext;
}

+ (AMDataManager *)sharedManager {
    static AMDataManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

+ (NSURL *)documentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                   inDomains:NSUserDomainMask] lastObject];
}

- (id)init {
    if (self = [super init]) {
        [self setupRestkitWithCoreData];
    }
    return self;
}

- (NSFetchedResultsController *)productsFRCForDelegate:(id<NSFetchedResultsControllerDelegate>)delegate {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"AMOProduct"];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO];
    fetchRequest.sortDescriptors = @[descriptor];
    
    // Setup fetched results
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                          managedObjectContext:[RKManagedObjectStore defaultStore].mainQueueManagedObjectContext
                                                                            sectionNameKeyPath:nil
                                                                                     cacheName:nil];
    frc.delegate = delegate;
    return frc;
}

- (void)loadProducts {
    // Load the object model via RestKit
    [[RKObjectManager sharedManager] getObjectsAtPath:kProductsPath
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  RKLogInfo(@"Load complete: Table should refresh...");
                                              } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  RKLogError(@"Load failed with error: %@", error);
                                              }];
}

//- (AMOProduct *)insertProductName:(NSString*)name
//                         category:(NSString*)category
//                          barcode:(int16_t)barcode
//                            price:(int16_t)price {
//    
//    AMOProduct *product = [AMOProduct insertInManagedObjectContext:_managedObjectContext];
//    
//    product.name = name;
//    product.category = category;
//    product.barcodeValue = barcode;
//    product.priceValue = price;
//    
//    [self saveContext];
//    return product;
//}

//- (void)saveContext {
//    if (_managedObjectContext != nil) {
//        NSError *error = nil;
//        if ([_managedObjectContext hasChanges] && ![_managedObjectContext save:&error]) {
//            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//            abort();
//        }
//    }
//}

- (void)setupRestkitWithCoreData {
    RKLogConfigureByName("RestKit", RKLogLevelWarning);
    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
    RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
    
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:kRestEndpointURL]];
    
    // Enable Activity Indicator Spinner
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    // Initialize managed object store
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    objectManager.managedObjectStore = managedObjectStore;
    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
//    [dateFormatter setLocale:enUSPOSIXLocale];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
//    [[RKValueTransformer defaultValueTransformer] insertValueTransformer:dateFormatter atIndex:0];
    
    
    RKEntityMapping *productMapping = [RKEntityMapping mappingForEntityForName:@"AMOProduct"
                                                       inManagedObjectStore:managedObjectStore];
    [productMapping addAttributeMappingsFromDictionary:@{
                                                        @"id" : @"productID",
                                                        @"price" : @"price",
                                                        @"category" : @"category",
                                                        @"brand" : @"name",
                                                        }];
    
    
    productMapping.identificationAttributes = @[@"productID"];
    
    // Register our mappings with the provider
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:productMapping
                                                                                            method:RKRequestMethodGET
                                                                                       pathPattern:kProductsPath
                                                                                           keyPath:nil
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:responseDescriptor];
    
    
    [managedObjectStore createPersistentStoreCoordinator];
    
    
    
    NSString *storePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"AMPersistentData.sqlite"];
    NSError *error;
    
    
    // Delete the existing store
    
    //-------------------------Temporary
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success = [fileManager removeItemAtPath:storePath error:&error];
    if (success) {
        NSLog(@"Deleted file -:%@ ",storePath);
    } else {
        NSLog(@"Could not delete file -:%@ ",[error localizedDescription]);
    }
    
    
    NSPersistentStore *persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:storePath
                                                                     fromSeedDatabaseAtPath:nil
                                                                          withConfiguration:nil
                                                                                    options:nil
                                                                                      error:&error];
    
    
    NSAssert(persistentStore, @"Failed to add persistent store with error: %@", error);
    
    // Create the managed object contexts
    [managedObjectStore createManagedObjectContexts];
    
    // Configure a managed object cache to ensure we do not create duplicate objects
    managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:managedObjectStore.persistentStoreManagedObjectContext];
    _managedObjectContext = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
    [RKObjectManager setSharedManager:objectManager];
}


@end
