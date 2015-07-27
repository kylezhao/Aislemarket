// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AMOUser.h instead.

#import <CoreData/CoreData.h>

extern const struct AMOUserAttributes {
	__unsafe_unretained NSString *email;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *phone;
} AMOUserAttributes;

@interface AMOUserID : NSManagedObjectID {}
@end

@interface _AMOUser : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AMOUserID* objectID;

@property (nonatomic, strong) NSString* email;

//- (BOOL)validateEmail:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* phone;

@property (atomic) int64_t phoneValue;
- (int64_t)phoneValue;
- (void)setPhoneValue:(int64_t)value_;

//- (BOOL)validatePhone:(id*)value_ error:(NSError**)error_;

@end

@interface _AMOUser (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveEmail;
- (void)setPrimitiveEmail:(NSString*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSNumber*)primitivePhone;
- (void)setPrimitivePhone:(NSNumber*)value;

- (int64_t)primitivePhoneValue;
- (void)setPrimitivePhoneValue:(int64_t)value_;

@end
