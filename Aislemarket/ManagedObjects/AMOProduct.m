#import "AMOProduct.h"

@interface AMOProduct ()

// Private interface goes here.

@end

@implementation AMOProduct

- (NSString *)formattedPrice {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSString *priceString = [numberFormatter stringFromNumber:self.price];
    return priceString;
}

- (NSString *)capitalisedName {
    return [self.name capitalizedString];
}

@end
