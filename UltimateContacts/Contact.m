//
//  Contact.m
//  UltimateContacts
//
//  Created by Daniel Judd on 1/19/13.
//  Copyright (c) 2013 Daniel Judd. All rights reserved.
//

#import "Contact.h"

@implementation Contact
- (id) init: (NSString*)firstName: (NSString*)lastName: (NSString*)company: (NSString*) email: (NSString*) mobile{
    if (self = [super init]){
        self.firstName = firstName;
        self.lastName = lastName;
        self.company = company;
        self.email = email;
        self.mobile = mobile;
    }
    return self;
}
@end
