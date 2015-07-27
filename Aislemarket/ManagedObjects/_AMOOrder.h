// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AMOOrder.h instead.

#import <CoreData/CoreData.h>

extern const struct AMOOrderAttributes {
	__unsafe_unretained NSString *deliveryTime;
	__unsafe_unretained NSString *orderID;
	__unsafe_unretained NSString *orderTime;
	__unsafe_unretained NSString *productIDs;
} AMOOrderAttributes;

extern const struct AMOOrderRelationships {
	__unsafe_unretained NSString *products;
} AMOOrderRelationships;

@class AMOProduct;

@class NSObject;

@interface AMOOrderID : NSManagedObjectID {}
@end

@interface _AMOOrder : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AMOOrderID* objectID;

@property (nonatomic, strong) NSDate* deliveryTime;

//- (BOOL)validateDeliveryTime:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* orderID;

@property (atomic) int16_t orderIDValue;
- (int16_t)orderIDValue;
- (void)setOrderIDValue:(int16_t)value_;

//- (BOOL)validateOrderID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* orderTime;

//- (BOOL)validateOrderTime:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) id productIDs;

//- (BOOL)validateProductIDs:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *products;

- (NSMutableSet*)productsSet;

@end

@interface _AMOOrder (ProductsCoreDataGeneratedAccessors)
- (void)addProducts:(NSSet*)value_;
- (void)removeProducts:(NSSet*)value_;
- (void)addProductsObject:(AMOProduct*)value_;
- (void)removeProductsObject:(AMOProduct*)value_;

@end

@interface _AMOOrder (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitiveDeliveryTime;
- (void)setPrimitiveDeliveryTime:(NSDate*)value;

- (NSNumber*)primitiveOrderID;
- (void)setPrimitiveOrderID:(NSNumber*)value;

- (int16_t)primitiveOrderIDValue;
- (void)setPrimitiveOrderIDValue:(int16_t)value_;

- (NSDate*)primitiveOrderTime;
- (void)setPrimitiveOrderTime:(NSDate*)value;

- (id)primitiveProductIDs;
- (void)setPrimitiveProductIDs:(id)value;

- (NSMutableSet*)primitiveProducts;
- (void)setPrimitiveProducts:(NSMutableSet*)value;

@end
