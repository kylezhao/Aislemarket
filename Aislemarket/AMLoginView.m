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
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:4.0f/255.0f
                                                                           green:191.0f/255.0f
                                                                            blue:143.0f/255.0f
                                                                           alpha:1.0];
    
//#ifdef DEBUG
//    self.emailField.text=@"p8zhao@uwaterloo.ca";
//    self.passwordField.text=@"AMarket123";
//#endif
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
    if (indexPath.section) {
        NSLog(@"Login: %@ : %@ ",self.emailField.text,self.passwordField.text);
        
        [AMDataManager.sharedManager loginUsername:self.emailField.text
                                          password:self.passwordField.text
                                           handler:^(BOOL succsess, NSError *__autoreleasing *error) {
            if (succsess) {
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                UITabBarController *tabController = (UITabBarController*)[storyboard instantiateViewControllerWithIdentifier:@"tabViewController"];
                [self showDetailViewController:tabController sender:self];
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
