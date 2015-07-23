// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AMOShoppingList.h instead.

#import <CoreData/CoreData.h>

extern const struct AMOShoppingListAttributes {
	__unsafe_unretained NSString *date;
	__unsafe_unretained NSString *name;
} AMOShoppingListAttributes;

extern const struct AMOShoppingListRelationships {
	__unsafe_unretained NSString *products;
} AMOShoppingListRelationships;

@class AMOProduct;

@interface AMOShoppingListID : NSManagedObjectID {}
@end

@interface _AMOShoppingList : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AMOShoppingListID* objectID;

@property (nonatomic, strong) NSDate* date;

//- (BOOL)validateDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSOrderedSet *products;

- (NSMutableOrderedSet*)productsSet;

@end

@interface _AMOShoppingList (ProductsCoreDataGeneratedAccessors)
- (void)addProducts:(NSOrderedSet*)value_;
- (void)removeProducts:(NSOrderedSet*)value_;
- (void)addProductsObject:(AMOProduct*)value_;
- (void)removeProductsObject:(AMOProduct*)value_;

- (void)insertObject:(AMOProduct*)value inProductsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromProductsAtIndex:(NSUInteger)idx;
- (void)insertProducts:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeProductsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInProductsAtIndex:(NSUInteger)idx withObject:(AMOProduct*)value;
- (void)replaceProductsAtIndexes:(NSIndexSet *)indexes withProducts:(NSArray *)values;

@end

@interface _AMOShoppingList (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitiveDate;
- (void)setPrimitiveDate:(NSDate*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSMutableOrderedSet*)primitiveProducts;
- (void)setPrimitiveProducts:(NSMutableOrderedSet*)value;

@end
