// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AMOShoppingList.h instead.

#import <CoreData/CoreData.h>

extern const struct AMOShoppingListAttributes {
	__unsafe_unretained NSString *autogenerate;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *productIDs;
	__unsafe_unretained NSString *shoppingListID;
	__unsafe_unretained NSString *time;
} AMOShoppingListAttributes;

extern const struct AMOShoppingListRelationships {
	__unsafe_unretained NSString *products;
} AMOShoppingListRelationships;

@class AMOProduct;

@class NSObject;

@interface AMOShoppingListID : NSManagedObjectID {}
@end

@interface _AMOShoppingList : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AMOShoppingListID* objectID;

@property (nonatomic, strong) NSNumber* autogenerate;

@property (atomic) BOOL autogenerateValue;
- (BOOL)autogenerateValue;
- (void)setAutogenerateValue:(BOOL)value_;

//- (BOOL)validateAutogenerate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) id productIDs;

//- (BOOL)validateProductIDs:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* shoppingListID;

//- (BOOL)validateShoppingListID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* time;

//- (BOOL)validateTime:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *products;

- (NSMutableSet*)productsSet;

@end

@interface _AMOShoppingList (ProductsCoreDataGeneratedAccessors)
- (void)addProducts:(NSSet*)value_;
- (void)removeProducts:(NSSet*)value_;
- (void)addProductsObject:(AMOProduct*)value_;
- (void)removeProductsObject:(AMOProduct*)value_;

@end

@interface _AMOShoppingList (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveAutogenerate;
- (void)setPrimitiveAutogenerate:(NSNumber*)value;

- (BOOL)primitiveAutogenerateValue;
- (void)setPrimitiveAutogenerateValue:(BOOL)value_;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (id)primitiveProductIDs;
- (void)setPrimitiveProductIDs:(id)value;

- (NSString*)primitiveShoppingListID;
- (void)setPrimitiveShoppingListID:(NSString*)value;

- (NSDate*)primitiveTime;
- (void)setPrimitiveTime:(NSDate*)value;

- (NSMutableSet*)primitiveProducts;
- (void)setPrimitiveProducts:(NSMutableSet*)value;

@end
