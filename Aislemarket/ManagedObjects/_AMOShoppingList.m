// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AMOShoppingList.m instead.

#import "_AMOShoppingList.h"

const struct AMOShoppingListAttributes AMOShoppingListAttributes = {
	.autogenerate = @"autogenerate",
	.name = @"name",
	.productIDs = @"productIDs",
	.shoppingListID = @"shoppingListID",
	.time = @"time",
};

const struct AMOShoppingListRelationships AMOShoppingListRelationships = {
	.products = @"products",
};

@implementation AMOShoppingListID
@end

@implementation _AMOShoppingList

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"AMOShoppingList" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"AMOShoppingList";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"AMOShoppingList" inManagedObjectContext:moc_];
}

- (AMOShoppingListID*)objectID {
	return (AMOShoppingListID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"autogenerateValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"autogenerate"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic autogenerate;

- (BOOL)autogenerateValue {
	NSNumber *result = [self autogenerate];
	return [result boolValue];
}

- (void)setAutogenerateValue:(BOOL)value_ {
	[self setAutogenerate:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveAutogenerateValue {
	NSNumber *result = [self primitiveAutogenerate];
	return [result boolValue];
}

- (void)setPrimitiveAutogenerateValue:(BOOL)value_ {
	[self setPrimitiveAutogenerate:[NSNumber numberWithBool:value_]];
}

@dynamic name;

@dynamic productIDs;

@dynamic shoppingListID;

@dynamic time;

@dynamic products;

- (NSMutableSet*)productsSet {
	[self willAccessValueForKey:@"products"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"products"];

	[self didAccessValueForKey:@"products"];
	return result;
}

@end

