#import "AMOProduct.h"

@interface AMOProduct ()

// Private interface goes here.

@end

@implementation AMOProduct

- (NSString *)formattedPrice {
//    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
//    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
//    NSString *priceString = [numberFormatter stringFromNumber:@(((float)self.priceValue)/100)];

    return @"$2.98";
}

@end
