//
//  AMShoppingListDetailView.m
//  Aislemarket
//
//  Created by Kyle Zhao on 2016-03-14.
//  Copyright © 2016 Kyle Zhao. All rights reserved.
//
#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

#import "AMShoppingListDetailView.h"
#import "AMDataManager.h"
#import "AMOProduct.h"

static NSString * const kProductCellID = @"productCell";

@interface AMShoppingListDetailView ()

@end

@implementation AMShoppingListDetailView {
    BOOL _inSwipeMode;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _inSwipeMode = NO;
    self.title = self.shoppingList.name;
    self.navigationController.navigationBar.topItem.title = @"Back";

    UIBarButtonItem * addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                target:self
                                                                                action:@selector(addProduct:)];
    [self.navigationItem setRightBarButtonItems:@[self.editButtonItem, addButton]];

    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor colorWithRed:4.0f/255.0f
                                                          green:191.0f/255.0f
                                                           blue:143.0f/255.0f
                                                          alpha:1.0];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(refreshProducts:)
                  forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setShoppingList:(AMOShoppingList *)shoppingList {
    if (_shoppingList != shoppingList) {
        _shoppingList = shoppingList;
    }
}

- (void)addProduct:(id)sender {

}

- (void)refreshProducts:(id)sender {
    [[AMDataManager sharedManager] loadShopplingListsHandler:^(BOOL succsess, NSError *__autoreleasing *error) {
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
    }];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    if (!editing) {
        [AMDataManager.sharedManager updateShoppingList:self.shoppingList handler:nil];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.shoppingList.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kProductCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kProductCellID];
    }
    [self configureCell:cell atIndexPath:indexPath];

    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    AMOProduct *product = self.shoppingList.products[indexPath.row];
    cell.textLabel.text = product.capitalisedName;
    cell.detailTextLabel.text = product.productID.description;//product.formattedPrice;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSMutableOrderedSet *products = self.shoppingList.productsSet;
        [products removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    NSMutableOrderedSet *products = self.shoppingList.productsSet;
    [products moveObjectsAtIndexes:[NSIndexSet indexSetWithIndex:fromIndexPath.row] toIndex:toIndexPath.row];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark - UITableViewDelegate

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSArray<UITableViewRowAction *> * actions;
    if(_inSwipeMode){
        UITableViewRowAction * hate =[UITableViewRowAction
                                      rowActionWithStyle:UITableViewRowActionStyleDestructive
                                      title:@"Hate"
                                      handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                          AMOProduct *p = self.shoppingList.products[indexPath.row];
                                          [AMDataManager.sharedManager satisfactionRequest:NO product:p handler:nil];
                                          [self.tableView setEditing:NO];
                                          NSLog(@"Hates Product: %@, %@",p.name, p.productID);
                                      }];

        UITableViewRowAction * like =[UITableViewRowAction
                                      rowActionWithStyle:UITableViewRowActionStyleNormal
                                      title:@"Like"
                                      handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                          AMOProduct *p = self.shoppingList.products[indexPath.row];
                                          [AMDataManager.sharedManager satisfactionRequest:YES product:p handler:nil];
                                          [self.tableView setEditing:NO];
                                          NSLog(@"Like Product: %@, %@",p.name, p.productID);
                                      }];

        like.backgroundColor = UIColorFromRGB(0x4CD964);
        actions = @[hate,like];
    } else {
        UITableViewRowAction * delete =[UITableViewRowAction
                                        rowActionWithStyle:UITableViewRowActionStyleDestructive
                                        title:@"Delete"
                                        handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
                                            [tableView beginUpdates];
                                            NSMutableOrderedSet *products = self.shoppingList.productsSet;
                                            [products removeObjectAtIndex:indexPath.row];
                                            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                                            [tableView endUpdates];
                                        }];
        actions = @[delete];
    }
    return actions;
}

- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    _inSwipeMode = YES;
    NSLog(@"Will Begin %@",indexPath);

}

- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    _inSwipeMode = NO;
    NSLog(@"didend %@",indexPath);
}

/*
 #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
