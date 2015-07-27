//
//  AMStoreSearchView.m
//  Aislemarket
//
//  Created by Kyle Zhao on 2015-07-23.
//  Copyright (c) 2015 Kyle Zhao. All rights reserved.
//

#import "AMStoreSearchView.h"
#import "AMOProduct.h"

static NSString * const kProductCellID = @"productCell";

@implementation AMStoreSearchView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredProducts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kProductCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kProductCellID];
    }
    AMOProduct *product = self.filteredProducts[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = product.capitalisedName;
    cell.detailTextLabel.text = product.formattedPrice;
    return cell;
}
@end
