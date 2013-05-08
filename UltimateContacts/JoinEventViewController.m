//
//  JoinEventViewController.m
//  UltimateContacts
//
//  Created by Daniel Judd on 1/19/13.
//  Copyright (c) 2013 Daniel Judd. All rights reserved.
//

#import "JoinEventViewController.h"
#import "AppDelegate.h"

@interface JoinEventViewController ()

@end

@implementation JoinEventViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)joinEvent:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    Contact *myContact = appDelegate.myContact;
    NSString *url = [NSString stringWithFormat:@"http://pennapps-2013s.herokuapp.com/services/pennapps/new/%@/%@/%@/%@/%@", _name.text, myContact.firstName, myContact.lastName, myContact.mobile, myContact.email];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"POST"];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
    
    NSDate *future = [NSDate dateWithTimeIntervalSinceNow: 0.06 ];
    [NSThread sleepUntilDate:future];
    
    NSString *url2 = [NSString stringWithFormat:@"http://pennapps-2013s.herokuapp.com/services/pennapps/user_events/%@", myContact.mobile];
    
    NSURLRequest *request2 = [NSURLRequest requestWithURL:[NSURL URLWithString:url2]];
    NSURLConnection *connection2 = [[NSURLConnection alloc] initWithRequest:request2 delegate:self];
    [connection2 start];


}

-(void) viewDidAppear:(BOOL)animated {
    [[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bglight.png"]]];
    UIImage *img=[UIImage imageNamed:@"joinevent.png"];
    [self.navigationController.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];

}

- (void)viewDidLoad
{
    [[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bglight.png"]]];
    UIImage *img=[UIImage imageNamed:@"joinevent.png"];
    [self.navigationController.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
    _name.returnKeyType = UIReturnKeyDone;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) doneButtonOnKeyboardPressed:(id)sender {
    [sender resignFirstResponder];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    _data = [[NSMutableData alloc] init];
    NSLog(@"here4");
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_data appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // Please do something sensible here, like log the error.
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"here5");
    
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:_data options:kNilOptions error:nil];
    NSLog(dictionary.description);
    
    for (NSDictionary* object in dictionary) {
        NSString *eventName = [object objectForKey:@"name"];
        NSLog([NSString stringWithFormat:@"Event: %@", eventName]);
        if (!([eventName isEqual:[NSNull null]])) {
            if ([eventName isEqualToString:_name.text]) {
                _confirmationTextView.text = [NSString stringWithFormat: @"You have successfully joined the event %@!", eventName];
                [self performSelector:@selector(fadeOutLabels) withObject:nil afterDelay:1.0f];
            }
        }
    }
}

-(void)fadeOutLabels
{
    
    [UIView animateWithDuration:1.0
                          delay:1.0  /* starts the animation after 3 seconds */
                        options:UIViewAnimationCurveEaseInOut
                     animations:^ {
                         _confirmationTextView.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         _confirmationTextView.text = @"";
                         //[_confirmationLabel removeFromSuperview];
                     }];
}

@end
