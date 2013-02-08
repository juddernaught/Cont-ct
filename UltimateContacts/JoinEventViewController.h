//
//  JoinEventViewController.h
//  UltimateContacts
//
//  Created by Daniel Judd on 1/19/13.
//  Copyright (c) 2013 Daniel Judd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JoinEventViewController : UIViewController {
    
}
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (nonatomic, retain) NSMutableData *data;

@property (weak,nonatomic) IBOutlet UITextView *confirmationTextView;

@end
