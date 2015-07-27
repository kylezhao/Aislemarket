// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AMOOrder.m instead.

#import "_AMOOrder.h"

const struct AMOOrderAttributes AMOOrderAttributes = {
	.deliveryTime = @"deliveryTime",
	.orderID = @"orderID",
	.orderTime = @"orderTime",
	.productIDs = @"productIDs",
};

const struct AMOOrderRelationships AMOOrderRelationships = {
	.products = @"products",
};

@implementation AMOOrderID
@end

@implementation _AMOOrder

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"AMOOrder" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"AMOOrder";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"AMOOrder" inManagedObjectContext:moc_];
}

- (AMOOrderID*)objectID {
	return (AMOOrderID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"orderIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"orderID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic deliveryTime;

@dynamic orderID;

- (int16_t)orderIDValue {
	NSNumber *result = [self orderID];
	return [result shortValue];
}

- (void)setOrderIDValue:(int16_t)value_ {
	[self setOrderID:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveOrderIDValue {
	NSNumber *result = [self primitiveOrderID];
	return [result shortValue];
}

- (void)setPrimitiveOrderIDValue:(int16_t)value_ {
	[self setPrimitiveOrderID:[NSNumber numberWithShort:value_]];
}

@dynamic orderTime;

@dynamic productIDs;

@dynamic products;

- (NSMutableSet*)productsSet {
	[self willAccessValueForKey:@"products"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"products"];

	[self didAccessValueForKey:@"products"];
	return result;
}

@end

