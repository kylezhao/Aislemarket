//
//  AMShoppingListDetailView.h
//  Aislemarket
//
//  Created by Kyle Zhao on 2016-03-14.
//  Copyright © 2016 Kyle Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMOShoppingList.h"
@class AMOProduct;

@interface AMShoppingListDetailView : UITableViewController

@property (nonatomic, strong) AMOShoppingList *shoppingList;

- (void)selectedProduct:(AMOProduct *)product;

@end
