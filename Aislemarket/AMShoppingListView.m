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

static NSString * const kShoppingListCellID = @"shoppingListCell";

@interface AMShoppingListView ()
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@end

@implementation AMShoppingListView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:4.0f/255.0f
                                                                           green:191.0f/255.0f
                                                                            blue:143.0f/255.0f
                                                                           alpha:1.0];
    
    self.fetchedResultsController = [AMDataManager.sharedManager shoppingListsFRCForDelegate:self];
    [AMDataManager.sharedManager loadShopplingLists];
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"ShopplingList fetchedResultsController failed %@, %@", error, [error userInfo]);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    
    NSString *listPreviewDetail;
    
    if (list.products.count > 2) {
        listPreviewDetail = [NSString.alloc initWithFormat:@"%@, %@, %@...",
                             [list.products.allObjects[0] name],
                             [list.products.allObjects[1] name],
                             [list.products.allObjects[2] name]];
    } else if (list.products.count > 1) {
        listPreviewDetail = [NSString.alloc initWithFormat:@"%@, %@",
                             [list.products.allObjects[0] name],
                             [list.products.allObjects[1] name]];
    } else {
        listPreviewDetail = [NSString.alloc initWithFormat:@"%@",[list.products.anyObject name]];
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
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
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