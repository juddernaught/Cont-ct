//
//  Contact.h
//  UltimateContacts
//
//  Created by Daniel Judd on 1/19/13.
//  Copyright (c) 2013 Daniel Judd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject
- (id) init: (NSString*)firstName: (NSString*)lastName: (NSString*)company: (NSString*) email: (NSString*) mobile;
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString *company;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *mobile;

@end
