//
//  ContactInfoViewController.h
//  UltimateContacts
//
//  Created by Daniel Judd on 1/19/13.
//  Copyright (c) 2013 Daniel Judd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"
#import <AddressBook/AddressBook.h>


@interface ContactInfoViewController : UIViewController {
     ABAddressBookRef addressBook;
}

@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *company;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *mobile;
@property (nonatomic, retain) Contact *myContact;

@end
