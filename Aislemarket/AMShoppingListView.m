//
//  AMShoppingListView.m
//  Aislemarket
//
//  Created by Kyle Zhao on 2015-07-27.
//  Copyright (c) 2015 Kyle Zhao. All rights reserved.
//

#import "AMShoppingListView.h"
#import "AMDataManager.h"
#import "AMOShoppingList.h"
#import "AMShoppingListDetailView.h"

static NSString * const kShoppingListCellID = @"shoppingListCell";

@interface AMShoppingListView ()
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@end

@implementation AMShoppingListView

- (void)viewDidLoad {
    [super viewDidLoad];

    self.fetchedResultsController = [AMDataManager.sharedManager shoppingListsFRCForDelegate:self];
    [[AMDataManager sharedManager] requestListsHandler:nil];

    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"ShopplingList fetchedResultsController failed %@, %@", error, [error userInfo]);
    }

    UIBarButtonItem *addButton =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                  target:self
                                                  action:@selector(newList:)];

    [self.navigationItem setRightBarButtonItem:addButton];

    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor colorWithRed:4.0f/255.0f
                                                          green:191.0f/255.0f
                                                           blue:143.0f/255.0f
                                                          alpha:1.0];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(refresh:)
                  forControlEvents:UIControlEventValueChanged];
}

- (void)newList:(id)sender {
    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:@"New Shopping List" message:nil
                                 preferredStyle:UIAlertControllerStyleAlert];

    [alert addTextFieldWithConfigurationHandler:
     ^(UITextField*textField){textField.placeholder=@"Name";}];

    UIAlertAction *create =
    [UIAlertAction actionWithTitle:@"Create"
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction *action) {
                               [alert dismissViewControllerAnimated:YES completion:nil];
                               [self createNewList:alert.textFields.firstObject.text];
                           }];

    UIAlertAction *cancel =
    [UIAlertAction actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleCancel
                           handler:^(UIAlertAction *action){
                               [alert dismissViewControllerAnimated:YES completion:nil];
                           }];

    [alert addAction:create];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)createNewList:(NSString *)name {
    if (name.length < 1) {
        UIAlertController *alert =
        [UIAlertController alertControllerWithTitle:@"Name Too Short"
                                            message:@"Please use a name longer then one character"
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok =
        [UIAlertAction actionWithTitle:@"Ok"
                                 style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action) {
                                   [alert dismissViewControllerAnimated:YES completion:nil];}];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
// Currently the API does not take the UUID instead it creates it
// Whould have to pass the name in then fetch from the server again
//    AMOShoppingList *list =
//    [AMOShoppingList insertInManagedObjectContext:[AMDataManager sharedManager].managedObjectContext];
//    [list setAutogenerateValue:NO];
//    [list setName:name];
//    [list setShoppingListID:[[NSUUID UUID] UUIDString]];
//    [list setTime:[NSDate date]];
//    [[AMDataManager sharedManager] saveContext];
    [[AMDataManager sharedManager] requestCreateList:name handler:^(BOOL succsess) {
        [[AMDataManager sharedManager] requestListsHandler:nil];
    }];
}

- (void)refresh:(id)sender {
    [[AMDataManager sharedManager] requestListsHandler:^(BOOL succsess) {
        [self.refreshControl endRefreshing];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kShoppingListCellID];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    AMOShoppingList *list = [self.fetchedResultsController objectAtIndexPath:indexPath];

    NSString *listPreviewDetail = nil;

    if (list.products.count > 3) {
        listPreviewDetail = [NSString.alloc initWithFormat:@"%@, %@, %@...",
                             [list.products[0] name],
                             [list.products[1] name],
                             [list.products[2] name]];
    } else if (list.products.count > 2) {
        listPreviewDetail = [NSString.alloc initWithFormat:@"%@, %@, %@",
                             [list.products[0] name],
                             [list.products[1] name],
                             [list.products[2] name]];
    } else if (list.products.count > 1) {
        listPreviewDetail = [NSString.alloc initWithFormat:@"%@, %@",
                             [list.products[0] name],
                             [list.products[1] name]];
    } else if (list.products.count > 0)  {
        listPreviewDetail = [NSString.alloc initWithFormat:@"%@",[list.products[0] name]];
    } else {
        listPreviewDetail = @"Empty List";
    }

    UILabel *nameLable = (UILabel *)[cell viewWithTag:3];
    UILabel *listPreviewLable = (UILabel *)[cell viewWithTag:1];
    UILabel *dateLable = (UILabel *)[cell viewWithTag:2];

    nameLable.text = list.name;
    listPreviewLable.text = listPreviewDetail;

    if (list.autogenerateValue) {
        dateLable.text = @"Autogenerated";
    } else {
        dateLable.text = [self formattedDate:list.time];
    }
}

- (NSString *)formattedDate:(NSDate *)date {

    NSDate *now = NSDate.date;
    NSDate *oneDayAgo = [now dateByAddingTimeInterval:-24*60*60];
    NSDate *oneWeekAgo = [now dateByAddingTimeInterval:-7*24*60*60];
    NSDateFormatter *formatter = NSDateFormatter.alloc.init;

    if ([date compare:oneDayAgo] == NSOrderedDescending) {
        [formatter setDateFormat:@"h:mm a"];
    } else if ([date compare:oneWeekAgo] == NSOrderedDescending) {
        [formatter setDateFormat:@"EEEE"];
    } else {
        formatter.timeStyle = NSDateFormatterNoStyle;
        formatter.dateStyle = NSDateFormatterMediumStyle;
        formatter.locale = NSLocale.currentLocale;
    }
    return [formatter stringFromDate:date];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
// Enable for deleting shopping lists
//if (editingStyle == UITableViewCellEditingStyleDelete) {
//    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
//    [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
//    [[AMDataManager sharedManager] saveContext];
//}
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"shoppingListDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        AMOShoppingList *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
        AMShoppingListDetailView *controller = (AMShoppingListDetailView *)[segue destinationViewController];
        [controller setShoppingList:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;

        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;

        default:
            return;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    UITableView *tableView = self.tableView;

    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;

        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;

        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;

        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

@end
