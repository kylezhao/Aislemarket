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

- (NSMutableOrderedSet*)productsSet {
	[self willAccessValueForKey:@"products"];

	NSMutableOrderedSet *result = (NSMutableOrderedSet*)[self mutableOrderedSetValueForKey:@"products"];

	[self didAccessValueForKey:@"products"];
	return result;
}

@end

@implementation _AMOShoppingList (ProductsCoreDataGeneratedAccessors)
- (void)addProducts:(NSOrderedSet*)value_ {
	[self.productsSet unionOrderedSet:value_];
}
- (void)removeProducts:(NSOrderedSet*)value_ {
	[self.productsSet minusOrderedSet:value_];
}
- (void)addProductsObject:(AMOProduct*)value_ {
	[self.productsSet addObject:value_];
}
- (void)removeProductsObject:(AMOProduct*)value_ {
	[self.productsSet removeObject:value_];
}
- (void)insertObject:(AMOProduct*)value inProductsAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"products"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self products]];
    [tmpOrderedSet insertObject:value atIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"products"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"products"];
}
- (void)removeObjectFromProductsAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"products"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self products]];
    [tmpOrderedSet removeObjectAtIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"products"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"products"];
}
- (void)insertProducts:(NSArray *)value atIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"products"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self products]];
    [tmpOrderedSet insertObjects:value atIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"products"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"products"];
}
- (void)removeProductsAtIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"products"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self products]];
    [tmpOrderedSet removeObjectsAtIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"products"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"products"];
}
- (void)replaceObjectInProductsAtIndex:(NSUInteger)idx withObject:(AMOProduct*)value {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"products"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self products]];
    [tmpOrderedSet replaceObjectAtIndex:idx withObject:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"products"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"products"];
}
- (void)replaceProductsAtIndexes:(NSIndexSet *)indexes withProducts:(NSArray *)value {
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"products"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self products]];
    [tmpOrderedSet replaceObjectsAtIndexes:indexes withObjects:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"products"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"products"];
}
@end

