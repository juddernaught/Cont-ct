//
//  CreateEventViewController.m
//  UltimateContacts
//
//  Created by Daniel Judd on 1/19/13.
//  Copyright (c) 2013 Daniel Judd. All rights reserved.
//

#import "CreateEventViewController.h"

@interface CreateEventViewController ()

@end
    
@implementation CreateEventViewController

- (void)viewDidLoad
{
    [[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bglight.png"]]];
    UIImage *img=[UIImage imageNamed:@"createevent.png"];
    [self.navigationController.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
    
    _name.returnKeyType = UIReturnKeyDone;
    _location.returnKeyType = UIReturnKeyDone;
    _phoneNumber.returnKeyType = UIReturnKeyDone;

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//event/{phone}/{name}/{location}
- (IBAction) createEvent {
    NSString *url = [NSString stringWithFormat:@"http://pennapps-2013s.herokuapp.com/services/pennapps/event/%@/%@/%@", _phoneNumber.text, _name.text, _location.text];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"POST"];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];

}

- (IBAction) doneButtonOnKeyboardPressed:(id)sender {
    [sender resignFirstResponder];
}

@end