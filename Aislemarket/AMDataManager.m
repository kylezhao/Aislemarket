//
//  AMDataManager.m
//  CoreDataFromScratch
//
//  Created by Kyle Zhao on 2015-07-21.
//  Copyright (c) 2015 Kyle Zhao. All rights reserved.
//

#import "AMDataManager.h"
#import "AMOProduct.h"
#import "AMOUser.h"
#import "AMOShoppingList.h"
#import <RestKit/RestKit.h>
#import <RestKit/CoreData.h>

static NSString * const kRestEndpointURL = @"http://104.236.229.162:8080";
static NSString * const kBasePath =        @"/simple-service-webapp/webapi/";
static NSString * const kOrdersPath =      @"orders/";
static NSString * const kShoppingListsPath=@"shoppinglists/";
static NSString * const kProductsPath =    @"/simple-service-webapp/webapi/products/";
static NSString * const kLoginPath =       @"/simple-service-webapp/webapi/users/login";

//http://104.236.229.162:8080/simple-service-webapp/webapi/products/
//http://104.236.229.162:8080/simple-service-webapp/webapi/p8zhao%40uwaterloo.ca/orders/
//http://104.236.229.162:8080/simple-service-webapp/webapi/p8zhao%40uwaterloo.ca/shoppinglists/
//http://104.236.229.162:8080/simple-service-webapp/webapi/users/login?userid=p8zhao%40uwaterloo.ca&password=AMarket123
//http://104.236.229.162:8080/simple-service-webapp/webapi/users/login?userid=p8zhao@uwatelroo.ca&password=AMarket123

@implementation AMDataManager {
    RKManagedObjectStore *_managedObjectStore;
}

+ (AMDataManager *)sharedManager {
    static AMDataManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        [self setupRestkitWithCoreData];
    }
    return self;
}

- (NSFetchedResultsController *)productsFRCForDelegate:(id<NSFetchedResultsControllerDelegate>)delegate {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"AMOProduct"];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    fetchRequest.sortDescriptors = @[descriptor];
    
    // Setup fetched results
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                          managedObjectContext:RKManagedObjectStore.defaultStore.mainQueueManagedObjectContext
                                                                            sectionNameKeyPath:nil
                                                                                     cacheName:nil];
    frc.delegate = delegate;
    return frc;
}
- (NSFetchedResultsController *)shoppingListsFRCForDelegate:(id<NSFetchedResultsControllerDelegate>)delegate {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"AMOShoppingList"];
    NSSortDescriptor *descriptor1 = [NSSortDescriptor sortDescriptorWithKey:@"autogenerate" ascending:YES];
    NSSortDescriptor *descriptor2 = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    fetchRequest.sortDescriptors = @[descriptor1,descriptor2];
    
    // Setup fetched results
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                          managedObjectContext:RKManagedObjectStore.defaultStore.mainQueueManagedObjectContext
                                                                            sectionNameKeyPath:nil
                                                                                     cacheName:nil];
    frc.delegate = delegate;
    return frc;
}
- (void)loginUsername:(NSString *)username password:(NSString *)password handler:(void (^)(BOOL, NSError *__autoreleasing *))handler {
    NSString *path =[[NSString alloc] initWithFormat:@"%@?userid=%@&password=%@",kLoginPath,username,password];
    [RKObjectManager.sharedManager getObjectsAtPath:path
                                         parameters:nil
                                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                AMOUser *user = mappingResult.firstObject;
                                                if (user) {
                                                    self.currentUser = user;
                                                    handler(YES,nil);
                                                } else {
                                                    handler(NO,nil);
                                                }
                                            } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                handler(NO,&error);
                                            }];
}
- (void)loadOrders {
    if (!self.currentUser) {assert(0);}
    
    RKResponseDescriptor *RDOrders = [self responseDescriptorOrder:self.mappingOrder];
    [RKObjectManager.sharedManager addResponseDescriptor:RDOrders];
    
    [RKObjectManager.sharedManager getObjectsAtPath:self.ordersPathFromCurrentUser
                                         parameters:nil
                                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                RKLogInfo(@"Loaded Orders:%@",mappingResult.dictionary);
                                            } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                RKLogError(@"Loading orders failed: %@", error);
                                            }];
}
- (void)loadProducts {
    [RKObjectManager.sharedManager getObjectsAtPath:kProductsPath
                                         parameters:nil
                                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                RKLogInfo(@"Loaded Products:%@",mappingResult.dictionary);
                                            } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                RKLogError(@"Load products failed: %@", error);
                                            }];
}
- (void)loadShopplingLists {
    if (!self.currentUser) {assert(0);}
    
    RKResponseDescriptor *RDShoppingList = [self responseDescriptorShoppingList:self.mappingShoppingList];
    [RKObjectManager.sharedManager addResponseDescriptor:RDShoppingList];
    
    [RKObjectManager.sharedManager getObjectsAtPath:self.shoppingListsPathFromCurrentUser
                                         parameters:nil
                                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                RKLogInfo(@"Loaded Shopping Lists:%@",mappingResult.dictionary);
                                            } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                RKLogError(@"Load ShoppingLists failed: %@", error);
                                            }];
}

- (NSString *)ordersPathFromCurrentUser {
    if(self.currentUser) {
        return [[NSString alloc] initWithFormat:@"%@%@/%@",kBasePath,self.currentUser.email,kOrdersPath];
    } else {
        assert(0);
    }
}

- (NSString *)shoppingListsPathFromCurrentUser {
    if(self.currentUser) {
        return [[NSString alloc] initWithFormat:@"%@%@/%@",kBasePath,self.currentUser.email,kShoppingListsPath];
    } else {
        assert(0);
    }
}

- (void)setupRestkitWithCoreData {
    RKLogConfigureByName("RestKit", RKLogLevelWarning);
    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
    RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
    
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    _managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:kRestEndpointURL]];
    objectManager.managedObjectStore = _managedObjectStore;
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    [_managedObjectStore createPersistentStoreCoordinator];
    
    NSString *storePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"AMPersistentData.sqlite"];
    // Delete Core Data for testing
    //[self tempDeleteStore:storePath];
    
    NSError *error;
    NSPersistentStore *persistentStore = [_managedObjectStore addSQLitePersistentStoreAtPath:storePath fromSeedDatabaseAtPath:nil
                                                                           withConfiguration:nil options:nil error:&error];
    
    NSAssert(persistentStore, @"Failed to add persistent store with error: %@", error);
    
    // Create the managed object contexts
    [_managedObjectStore createManagedObjectContexts];
    
    // Configure a managed object cache to ensure we do not create duplicate objects
    _managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:_managedObjectStore.persistentStoreManagedObjectContext];
    RKManagedObjectStore.defaultStore = _managedObjectStore;
    _managedObjectContext = RKManagedObjectStore.defaultStore.mainQueueManagedObjectContext;
    
    RKResponseDescriptor *RDUser = [self responseDescriptorUser:self.mappingUser];
    RKResponseDescriptor *RDProduct = [self responseDescriptorProduct:self.mappingProduct];
    [objectManager addResponseDescriptorsFromArray:@[RDProduct, RDUser]];
    
    RKObjectManager.sharedManager = objectManager;
}

#pragma mark - RKEntityMapping Factory Helpers

- (RKEntityMapping *)mappingUser {
    RKEntityMapping *mapping = [RKEntityMapping mappingForEntityForName:@"AMOUser" inManagedObjectStore:_managedObjectStore];
    [mapping addAttributeMappingsFromArray:@[@"email",@"name",@"phone"]];
    mapping.identificationAttributes = @[@"email"];
    return mapping;
}
- (RKEntityMapping *)mappingOrder {
    RKEntityMapping *mapping = [RKEntityMapping mappingForEntityForName:@"AMOOrder" inManagedObjectStore:_managedObjectStore];
    [mapping addAttributeMappingsFromDictionary:@{@"id":@"orderID", @"products":@"productIDs"}];
    
    RKAttributeMapping *orderTimeMapping = [RKAttributeMapping attributeMappingFromKeyPath:@"orderTime" toKeyPath:@"orderTime"];
    orderTimeMapping.valueTransformer = RKValueTransformer.iso8601TimestampToDateValueTransformer;
    [mapping addPropertyMapping:orderTimeMapping];
    
    RKAttributeMapping *deliveryTimeMapping = [RKAttributeMapping attributeMappingFromKeyPath:@"deliveryTime" toKeyPath:@"deliveryTime"];
    deliveryTimeMapping.valueTransformer = RKValueTransformer.iso8601TimestampToDateValueTransformer;
    [mapping addPropertyMapping:deliveryTimeMapping];
    
    NSEntityDescription *ordersEntity = [NSEntityDescription entityForName:@"AMOOrder" inManagedObjectContext:_managedObjectContext];
    NSRelationshipDescription *productsRelation = [ordersEntity relationshipsByName][@"products"];
    RKConnectionDescription *connection = [[RKConnectionDescription alloc] initWithRelationship:productsRelation attributes:@{ @"productIDs": @"productID" }];
    
    [mapping addConnection:connection];
    mapping.identificationAttributes = @[@"orderID"];
    return mapping;
}
- (RKEntityMapping *)mappingProduct {
    RKEntityMapping *mapping = [RKEntityMapping mappingForEntityForName:@"AMOProduct" inManagedObjectStore:_managedObjectStore];
    [mapping addAttributeMappingsFromDictionary:@{@"id":@"productID",
                                                  @"brand":@"name"}];
    [mapping addAttributeMappingsFromArray:@[@"price",@"category"]];
    mapping.identificationAttributes = @[@"productID"];
    return mapping;
}
- (RKEntityMapping *)mappingShoppingList {
    RKEntityMapping *mapping = [RKEntityMapping mappingForEntityForName:@"AMOShoppingList" inManagedObjectStore:_managedObjectStore];
    [mapping addAttributeMappingsFromDictionary:@{@"id":@"shoppingListID", @"products":@"productIDs"}];
    [mapping addAttributeMappingsFromArray:@[@"name", @"autogenerate"]];
    
    RKAttributeMapping *timeMapping = [RKAttributeMapping attributeMappingFromKeyPath:@"time" toKeyPath:@"time"];
    timeMapping.valueTransformer = RKValueTransformer.iso8601TimestampToDateValueTransformer;
    
    [mapping addPropertyMapping:timeMapping];
    
    NSEntityDescription *shoppingListEntity = [NSEntityDescription entityForName:@"AMOShoppingList" inManagedObjectContext:_managedObjectContext];
    NSRelationshipDescription *productsRelation = [shoppingListEntity relationshipsByName][@"products"];
    RKConnectionDescription *connection = [[RKConnectionDescription alloc] initWithRelationship:productsRelation attributes:@{ @"productIDs": @"productID" }];
    
    [mapping addConnection:connection];
    mapping.identificationAttributes = @[@"shoppingListID"];
    return mapping;
}

#pragma mark - RKEntityMapping Factory Helpers

- (RKResponseDescriptor *)responseDescriptorUser:(RKEntityMapping *)mapping {
    return [RKResponseDescriptor responseDescriptorWithMapping:mapping
                                                        method:RKRequestMethodGET
                                                   pathPattern:kLoginPath
                                                       keyPath:nil
                                                   statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
}
- (RKResponseDescriptor *)responseDescriptorOrder:(RKEntityMapping *)mapping {
    return [RKResponseDescriptor responseDescriptorWithMapping:mapping
                                                        method:RKRequestMethodGET
                                                   pathPattern:self.ordersPathFromCurrentUser
                                                       keyPath:nil
                                                   statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
}
- (RKResponseDescriptor *)responseDescriptorProduct:(RKEntityMapping *)mapping {
    return [RKResponseDescriptor responseDescriptorWithMapping:mapping
                                                        method:RKRequestMethodGET
                                                   pathPattern:kProductsPath
                                                       keyPath:nil
                                                   statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
}
- (RKResponseDescriptor *)responseDescriptorShoppingList:(RKEntityMapping *)mapping {
    return [RKResponseDescriptor responseDescriptorWithMapping:mapping
                                                        method:RKRequestMethodGET
                                                   pathPattern:self.shoppingListsPathFromCurrentUser
                                                       keyPath:nil
                                                   statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
}

// Clear Core Data
- (void)tempDeleteStore:(NSString *)storePath {
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success = [fileManager removeItemAtPath:storePath error:&error];
    if (success) {
        NSLog(@"Deleted file %@ ",storePath);
    } else {
        NSLog(@"Could not delete file %@ ",[error localizedDescription]);
    }
}

@end



//
//
//    //temp
//
//
//    AMDataManager * manager = AMDataManager.sharedManager;
//    [manager loginUsername:@"p8zhao@uwaterloo.ca" password:@"AMarket123"];
//
//
//
//    // Delay execution of my block for 3 seconds.
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//        NSLog(@"Fetching----------------");
//        NSManagedObjectContext *moc = manager.managedObjectContext;
//        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"AMOUser" inManagedObjectContext:moc];
//        NSFetchRequest *request = [[NSFetchRequest alloc] init];
//        [request setEntity:entityDescription];
//
//        NSError *error;
//        NSArray *array = [moc executeFetchRequest:request error:&error];
//        if (array == nil)
//        {
//            // Deal with error...
//        }
//        NSLog(@"Users : %@", array);
//        AMOUser *user = array[0];
//        NSLog(@"%@,%@,%ld",user.name,user.email,(long)user.phone.integerValue);
//
//        manager.currentUser = array[0];
//
//        [manager loadProducts];
//        [manager loadShopplingLists];
//        [manager loadOrders];
//
//
//    });
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//        NSLog(@"Fetching Shoppinglists----------------");
//        NSManagedObjectContext *moc = manager.managedObjectContext;
//        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"AMOShoppingList" inManagedObjectContext:moc];
//        NSFetchRequest *request = [[NSFetchRequest alloc] init];
//        [request setEntity:entityDescription];
//
//        NSError *error;
//        NSArray *array = [moc executeFetchRequest:request error:&error];
//        if (array == nil)
//        {
//            // Deal with error...
//        }
//        NSLog(@"shopping lists : %@", array);
//
//        for (AMOShoppingList *list in array) {
//            NSLog(@"%@,%@",list.time,list.shoppingListID);
//
//            NSSet * products = list.products;
//
//            for (AMOProduct *temp in products) {
//                NSLog(@"Product : %@  id:%@",temp.name,temp.productID);
//            }
//        }
//
////        AMOUser *user = array[0];
////        NSLog(@"%@,%@,%ld",user.name,user.email,(long)user.phone.integerValue);
////
////        manager.currentUser = array[0];
////
////        [manager loadShopplingLists];
////
//    });
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//        NSLog(@"Fetching Orders----------------");
//        NSManagedObjectContext *moc = manager.managedObjectContext;
//        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"AMOOrder" inManagedObjectContext:moc];
//        NSFetchRequest *request = [[NSFetchRequest alloc] init];
//        [request setEntity:entityDescription];
//
//        NSError *error;
//        NSArray *array = [moc executeFetchRequest:request error:&error];
//        if (array == nil)
//        {
//            // Deal with error...
//        }
//        NSLog(@"Orders : %@", array);
//
//        for (AMOOrder *order in array) {
//            NSLog(@"id:%@ time%@",order.orderID,order.orderTime);
//
//            NSSet * products = order.products;
//
//            for (AMOProduct *temp in products) {
//                NSLog(@"id%@  ordertime:%@",temp.name,temp.productID);
//            }
//        }
//
//        //        AMOUser *user = array[0];
//        //        NSLog(@"%@,%@,%ld",user.name,user.email,(long)user.phone.integerValue);
//        //
//        //        manager.currentUser = array[0];
//        //
//        //        [manager loadShopplingLists];
//        //
//    });
//






/*
 - (AMOProduct *)insertProductName:(NSString*)name
 category:(NSString*)category
 barcode:(int16_t)barcode
 price:(int16_t)price {
 
 AMOProduct *product = [AMOProduct insertInManagedObjectContext:_managedObjectContext];
 
 product.name = name;
 product.category = category;
 product.barcodeValue = barcode;
 product.priceValue = price;
 
 [self saveContext];
 return product;
 }
 
 - (void)saveContext {
 if (_managedObjectContext != nil) {
 NSError *error = nil;
 if ([_managedObjectContext hasChanges] && ![_managedObjectContext save:&error]) {
 NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
 abort();
 }
 }
 }
 */