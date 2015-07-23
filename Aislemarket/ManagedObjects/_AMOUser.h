// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AMOUser.h instead.

#import <CoreData/CoreData.h>

extern const struct AMOUserAttributes {
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *phone;
	__unsafe_unretained NSString *userid;
} AMOUserAttributes;

@interface AMOUserID : NSManagedObjectID {}
@end

@interface _AMOUser : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AMOUserID* objectID;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* phone;

@property (atomic) int16_t phoneValue;
- (int16_t)phoneValue;
- (void)setPhoneValue:(int16_t)value_;

//- (BOOL)validatePhone:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* userid;

//- (BOOL)validateUserid:(id*)value_ error:(NSError**)error_;

@end

@interface _AMOUser (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSNumber*)primitivePhone;
- (void)setPrimitivePhone:(NSNumber*)value;

- (int16_t)primitivePhoneValue;
- (void)setPrimitivePhoneValue:(int16_t)value_;

- (NSString*)primitiveUserid;
- (void)setPrimitiveUserid:(NSString*)value;

@end
