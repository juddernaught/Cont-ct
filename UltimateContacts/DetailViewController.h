//
//  DetailViewController.h
//  Helping2
//
//  Created by Daniel Judd on 1/20/13.
//  Copyright (c) 2013 Daniel Judd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>

@interface DetailViewController : UIViewController {
        ABAddressBookRef addressBook;
}

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (nonatomic, retain) NSMutableData *data;

@end
