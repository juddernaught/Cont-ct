//
//  CreateEventViewController.h
//  UltimateContacts
//
//  Created by Daniel Judd on 1/19/13.
//  Copyright (c) 2013 Daniel Judd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateEventViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *location;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;

@end