//
//  AMLoginView.m
//  Aislemarket
//
//  Created by Kyle Zhao on 2015-07-26.
//  Copyright (c) 2015 Kyle Zhao. All rights reserved.
//

#import "AMLoginView.h"
#import "AMDataManager.h"

@interface AMLoginView ()
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@end

@implementation AMLoginView

- (void)viewDidLoad {
    [super viewDidLoad];

#ifdef DEBUG
    self.emailField.text=@"p8zhao@uwaterloo.ca";
    self.passwordField.text=@"AMarket123";
#endif
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section?1:2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        NSLog(@"Login: %@ : %@ ",self.emailField.text,self.passwordField.text);

        [AMDataManager.sharedManager requestLogin:self.emailField.text
                                         password:self.passwordField.text
                                          handler:
         ^(BOOL succsess) {
             if (succsess) {
                 UIWindow *window = UIApplication.sharedApplication.delegate.window;
                 window.rootViewController =
                 [window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"tabViewController"];
             } else {
                 UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid Credentials"
                                                                                message:@"Please check your Email and Password are correct"
                                                                         preferredStyle:UIAlertControllerStyleAlert];

                 UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action) {
                                                                [alert dismissViewControllerAnimated:YES completion:nil];
                                                            }];
                 [alert addAction:ok];
                 [self presentViewController:alert animated:YES completion:nil];

             }
         }];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
