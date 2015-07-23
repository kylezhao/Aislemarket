// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AMOProduct.h instead.

#import <CoreData/CoreData.h>

extern const struct AMOProductAttributes {
	__unsafe_unretained NSString *category;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *price;
	__unsafe_unretained NSString *productID;
} AMOProductAttributes;

@interface AMOProductID : NSManagedObjectID {}
@end

@interface _AMOProduct : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AMOProductID* objectID;

@property (nonatomic, strong) NSString* category;

//- (BOOL)validateCategory:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* price;

@property (atomic) int16_t priceValue;
- (int16_t)priceValue;
- (void)setPriceValue:(int16_t)value_;

//- (BOOL)validatePrice:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* productID;

@property (atomic) int16_t productIDValue;
- (int16_t)productIDValue;
- (void)setProductIDValue:(int16_t)value_;

//- (BOOL)validateProductID:(id*)value_ error:(NSError**)error_;

@end

@interface _AMOProduct (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveCategory;
- (void)setPrimitiveCategory:(NSString*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSNumber*)primitivePrice;
- (void)setPrimitivePrice:(NSNumber*)value;

- (int16_t)primitivePriceValue;
- (void)setPrimitivePriceValue:(int16_t)value_;

- (NSNumber*)primitiveProductID;
- (void)setPrimitiveProductID:(NSNumber*)value;

- (int16_t)primitiveProductIDValue;
- (void)setPrimitiveProductIDValue:(int16_t)value_;

@end
