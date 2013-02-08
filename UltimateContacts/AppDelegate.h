//
//  AppDelegate.h
//  UltimateContacts
//
//  Created by Daniel Judd on 1/18/13.
//  Copyright (c) 2013 Daniel Judd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) Contact* myContact;

-save : (Contact*) contact;

@end
