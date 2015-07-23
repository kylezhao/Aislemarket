// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AMOProduct.m instead.

#import "_AMOProduct.h"

const struct AMOProductAttributes AMOProductAttributes = {
	.category = @"category",
	.name = @"name",
	.price = @"price",
	.productID = @"productID",
};

@implementation AMOProductID
@end

@implementation _AMOProduct

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"AMOProduct" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"AMOProduct";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"AMOProduct" inManagedObjectContext:moc_];
}

- (AMOProductID*)objectID {
	return (AMOProductID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"priceValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"price"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"productIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"productID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic category;

@dynamic name;

@dynamic price;

- (int16_t)priceValue {
	NSNumber *result = [self price];
	return [result shortValue];
}

- (void)setPriceValue:(int16_t)value_ {
	[self setPrice:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitivePriceValue {
	NSNumber *result = [self primitivePrice];
	return [result shortValue];
}

- (void)setPrimitivePriceValue:(int16_t)value_ {
	[self setPrimitivePrice:[NSNumber numberWithShort:value_]];
}

@dynamic productID;

- (int16_t)productIDValue {
	NSNumber *result = [self productID];
	return [result shortValue];
}

- (void)setProductIDValue:(int16_t)value_ {
	[self setProductID:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveProductIDValue {
	NSNumber *result = [self primitiveProductID];
	return [result shortValue];
}

- (void)setPrimitiveProductIDValue:(int16_t)value_ {
	[self setPrimitiveProductID:[NSNumber numberWithShort:value_]];
}

@end

