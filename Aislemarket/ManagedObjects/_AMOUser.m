// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AMOUser.m instead.

#import "_AMOUser.h"

const struct AMOUserAttributes AMOUserAttributes = {
	.name = @"name",
	.phone = @"phone",
	.userid = @"userid",
};

@implementation AMOUserID
@end

@implementation _AMOUser

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"AMOUser" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"AMOUser";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"AMOUser" inManagedObjectContext:moc_];
}

- (AMOUserID*)objectID {
	return (AMOUserID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"phoneValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"phone"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic name;

@dynamic phone;

- (int16_t)phoneValue {
	NSNumber *result = [self phone];
	return [result shortValue];
}

- (void)setPhoneValue:(int16_t)value_ {
	[self setPhone:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitivePhoneValue {
	NSNumber *result = [self primitivePhone];
	return [result shortValue];
}

- (void)setPrimitivePhoneValue:(int16_t)value_ {
	[self setPrimitivePhone:[NSNumber numberWithShort:value_]];
}

@dynamic userid;

@end

