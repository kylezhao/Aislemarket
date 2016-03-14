//
//  AMSettingsViewController.m
//  Aislemarket
//
//  Created by Kyle Zhao on 2015-07-18.
//  Copyright (c) 2015 Kyle Zhao. All rights reserved.
//

#import "AMSettingsViewController.h"
#import "AMDataManager.h"
#import "AMOUser.h"

static NSString * const kSettingsCellID = @"settingsCell";

@interface AMSettingsViewController ()

@property (nonatomic, strong) NSArray *reuseIdentifiers;
@property (nonatomic, strong) NSArray *headerTitles;
@property (nonatomic, strong) NSArray *cellContent;

@end

@implementation AMSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.reuseIdentifiers = @[@[@"cellName", @"cellEmail", @"cellPassword",@"cellPhone"],
                              @[@"cellCreditCard",@"cellCardNumber",@"cellSecurityCode",@"cellExpiryDate"],
                              @[@"cellAddress",@"cellCity",@"cellProvince",@"cellPostalCode",@"cellCountry"],
                              @[@"cellLogout"]];
    self.headerTitles = @[@"account settings ", @"payment information", @"delivery address"];
    AMOUser *currentUser = AMDataManager.sharedManager.currentUser;
    self.cellContent = @[@[currentUser.name, currentUser.email, @"Change Password", currentUser.phone.stringValue],
                         @[@"Master Card", @"•••• •••• •••• 8793", @"•••",@"••/••••"],
                         @[@"200 University Avenue West", @"Waterloo", @"Ontario", @"N2L 3G1", @"Canada"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == self.reuseIdentifiers.count - 1) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Are you sure you wish to Logout?"
                                                                       message:nil
                                                                preferredStyle:UIAlertControllerStyleActionSheet];

        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel"
                                                         style:UIAlertActionStyleCancel
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           [alert dismissViewControllerAnimated:YES completion:nil];
                                                       }];

        void (^handler)(UIAlertAction * _Nonnull action) = ^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
            [AMDataManager.sharedManager clearCoreData];
            UIWindow *window = UIApplication.sharedApplication.delegate.window;
            window.rootViewController =
            [window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
        };
        UIAlertAction *logout = [UIAlertAction actionWithTitle:@"Logout"
                                                         style:UIAlertActionStyleDestructive
                                                       handler:handler];
        [alert addAction:cancel];
        [alert addAction:logout];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.reuseIdentifiers.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.reuseIdentifiers[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.reuseIdentifiers[indexPath.section][indexPath.row]
                                                            forIndexPath:indexPath];
    if (indexPath.section < self.cellContent.count) {
        cell.detailTextLabel.text = self.cellContent[indexPath.section][indexPath.row];
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section < self.headerTitles.count) {
        return [self.headerTitles[section] uppercaseString];
    }
    return nil;
}

@end
