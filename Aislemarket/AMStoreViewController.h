//
//  AMStoreViewController.h
//  Aislemarket
//
//  Created by Kyle Zhao on 2015-07-18.
//  Copyright (c) 2015 Kyle Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AMStoreViewController : UITableViewController <
UISearchBarDelegate,
UISearchResultsUpdating,
UISearchControllerDelegate,
NSFetchedResultsControllerDelegate
>
@end
