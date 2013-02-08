//
//  MasterViewController.h
//  Helping
//
//  Created by Daniel Judd on 1/20/13.
//  Copyright (c) 2013 Daniel Judd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface MasterEventsViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
