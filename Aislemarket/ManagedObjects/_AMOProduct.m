// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AMOProduct.m instead.

#import "_AMOProduct.h"

const struct AMOProductAttributes AMOProductAttributes = {
	.category = @"category",
	.inventory = @"inventory",
	.name = @"name",
	.price = @"price",
	.productID = @"productID",
};

const struct AMOProductRelationships AMOProductRelationships = {
	.shopplingLists = @"shopplingLists",
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

	if ([key isEqualToString:@"inventoryValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"inventory"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
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

@dynamic inventory;

- (int16_t)inventoryValue {
	NSNumber *result = [self inventory];
	return [result shortValue];
}

- (void)setInventoryValue:(int16_t)value_ {
	[self setInventory:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveInventoryValue {
	NSNumber *result = [self primitiveInventory];
	return [result shortValue];
}

- (void)setPrimitiveInventoryValue:(int16_t)value_ {
	[self setPrimitiveInventory:[NSNumber numberWithShort:value_]];
}

@dynamic name;

@dynamic price;

- (float)priceValue {
	NSNumber *result = [self price];
	return [result floatValue];
}

- (void)setPriceValue:(float)value_ {
	[self setPrice:[NSNumber numberWithFloat:value_]];
}

- (float)primitivePriceValue {
	NSNumber *result = [self primitivePrice];
	return [result floatValue];
}

- (void)setPrimitivePriceValue:(float)value_ {
	[self setPrimitivePrice:[NSNumber numberWithFloat:value_]];
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

@dynamic shopplingLists;

- (NSMutableOrderedSet*)shopplingListsSet {
	[self willAccessValueForKey:@"shopplingLists"];

	NSMutableOrderedSet *result = (NSMutableOrderedSet*)[self mutableOrderedSetValueForKey:@"shopplingLists"];

	[self didAccessValueForKey:@"shopplingLists"];
	return result;
}

@end

@implementation _AMOProduct (ShopplingListsCoreDataGeneratedAccessors)
- (void)addShopplingLists:(NSOrderedSet*)value_ {
	[self.shopplingListsSet unionOrderedSet:value_];
}
- (void)removeShopplingLists:(NSOrderedSet*)value_ {
	[self.shopplingListsSet minusOrderedSet:value_];
}
- (void)addShopplingListsObject:(AMOShoppingList*)value_ {
	[self.shopplingListsSet addObject:value_];
}
- (void)removeShopplingListsObject:(AMOShoppingList*)value_ {
	[self.shopplingListsSet removeObject:value_];
}
- (void)insertObject:(AMOShoppingList*)value inShopplingListsAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"shopplingLists"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self shopplingLists]];
    [tmpOrderedSet insertObject:value atIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"shopplingLists"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"shopplingLists"];
}
- (void)removeObjectFromShopplingListsAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"shopplingLists"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self shopplingLists]];
    [tmpOrderedSet removeObjectAtIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"shopplingLists"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"shopplingLists"];
}
- (void)insertShopplingLists:(NSArray *)value atIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"shopplingLists"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self shopplingLists]];
    [tmpOrderedSet insertObjects:value atIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"shopplingLists"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"shopplingLists"];
}
- (void)removeShopplingListsAtIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"shopplingLists"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self shopplingLists]];
    [tmpOrderedSet removeObjectsAtIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"shopplingLists"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"shopplingLists"];
}
- (void)replaceObjectInShopplingListsAtIndex:(NSUInteger)idx withObject:(AMOShoppingList*)value {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"shopplingLists"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self shopplingLists]];
    [tmpOrderedSet replaceObjectAtIndex:idx withObject:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"shopplingLists"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"shopplingLists"];
}
- (void)replaceShopplingListsAtIndexes:(NSIndexSet *)indexes withShopplingLists:(NSArray *)value {
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"shopplingLists"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self shopplingLists]];
    [tmpOrderedSet replaceObjectsAtIndexes:indexes withObjects:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"shopplingLists"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"shopplingLists"];
}
@end

