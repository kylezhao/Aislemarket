#import "AMOProduct.h"

@interface AMOProduct ()

// Private interface goes here.

@end

@implementation AMOProduct

- (NSString *)formattedPrice {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    // self.price is integer of cents
    NSString *priceString = [numberFormatter stringFromNumber:@(self.price.floatValue/100)];
    return priceString;
}

- (NSString *)capitalisedName {
    return [self.name capitalizedString];
}

@end
