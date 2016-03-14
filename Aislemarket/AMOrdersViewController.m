//
//  AMOrdersViewController.m
//  Aislemarket
//
//  Created by Kyle Zhao on 2015-07-18.
//  Copyright (c) 2015 Kyle Zhao. All rights reserved.
//

#import "AMOrdersViewController.h"

static NSString * const kOrdersCellID = @"ordersCell";

@interface AMOrdersViewController ()

@end

@implementation AMOrdersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kOrdersCellID forIndexPath:indexPath];
    
    return cell;
}

@end
