// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AMOProduct.h instead.

#import <CoreData/CoreData.h>

extern const struct AMOProductAttributes {
	__unsafe_unretained NSString *category;
	__unsafe_unretained NSString *inventory;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *price;
	__unsafe_unretained NSString *productID;
} AMOProductAttributes;

extern const struct AMOProductRelationships {
	__unsafe_unretained NSString *shopplingLists;
} AMOProductRelationships;

@class AMOShoppingList;

@interface AMOProductID : NSManagedObjectID {}
@end

@interface _AMOProduct : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AMOProductID* objectID;

@property (nonatomic, strong) NSString* category;

//- (BOOL)validateCategory:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* inventory;

@property (atomic) int16_t inventoryValue;
- (int16_t)inventoryValue;
- (void)setInventoryValue:(int16_t)value_;

//- (BOOL)validateInventory:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* price;

@property (atomic) float priceValue;
- (float)priceValue;
- (void)setPriceValue:(float)value_;

//- (BOOL)validatePrice:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* productID;

@property (atomic) int16_t productIDValue;
- (int16_t)productIDValue;
- (void)setProductIDValue:(int16_t)value_;

//- (BOOL)validateProductID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSOrderedSet *shopplingLists;

- (NSMutableOrderedSet*)shopplingListsSet;

@end

@interface _AMOProduct (ShopplingListsCoreDataGeneratedAccessors)
- (void)addShopplingLists:(NSOrderedSet*)value_;
- (void)removeShopplingLists:(NSOrderedSet*)value_;
- (void)addShopplingListsObject:(AMOShoppingList*)value_;
- (void)removeShopplingListsObject:(AMOShoppingList*)value_;

- (void)insertObject:(AMOShoppingList*)value inShopplingListsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromShopplingListsAtIndex:(NSUInteger)idx;
- (void)insertShopplingLists:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeShopplingListsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInShopplingListsAtIndex:(NSUInteger)idx withObject:(AMOShoppingList*)value;
- (void)replaceShopplingListsAtIndexes:(NSIndexSet *)indexes withShopplingLists:(NSArray *)values;

@end

@interface _AMOProduct (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveCategory;
- (void)setPrimitiveCategory:(NSString*)value;

- (NSNumber*)primitiveInventory;
- (void)setPrimitiveInventory:(NSNumber*)value;

- (int16_t)primitiveInventoryValue;
- (void)setPrimitiveInventoryValue:(int16_t)value_;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSNumber*)primitivePrice;
- (void)setPrimitivePrice:(NSNumber*)value;

- (float)primitivePriceValue;
- (void)setPrimitivePriceValue:(float)value_;

- (NSNumber*)primitiveProductID;
- (void)setPrimitiveProductID:(NSNumber*)value;

- (int16_t)primitiveProductIDValue;
- (void)setPrimitiveProductIDValue:(int16_t)value_;

- (NSMutableOrderedSet*)primitiveShopplingLists;
- (void)setPrimitiveShopplingLists:(NSMutableOrderedSet*)value;

@end
