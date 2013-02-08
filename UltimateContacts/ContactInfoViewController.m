//
//  ContactInfoViewController.m
//  UltimateContacts
//
//  Created by Daniel Judd on 1/19/13.
//  Copyright (c) 2013 Daniel Judd. All rights reserved.
//

#import "ContactInfoViewController.h"
#import "AppDelegate.h"


@interface ContactInfoViewController ()

@end

@implementation ContactInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    _myContact = [[Contact alloc] init:_firstName.text :_lastName.text :_company.text :_email.text :_mobile.text];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    appDelegate.myContact = _myContact;
    
    [self createUser];
    
}

/*- (IBAction)testCreationOfContact {
    NSLog(@"hello");
    CFErrorRef anError = NULL;
    ABRecordRef aRecord = ABPersonCreate();
    bool didSet;
    didSet = ABRecordSetValue(aRecord, kABPersonFirstNameProperty, CFSTR("Daniel"),
                              &anError);
    if (!didSet) {/* Handle error here. }
    didSet = ABRecordSetValue(aRecord, kABPersonLastNameProperty, CFSTR("Judd"),
                              &anError);


    //ABMutableMultiValueRef multiPhone = ABMultiValueCreateMutable(kABMultiStringPropertyType);

   /* NSString *number = @"(203) 832-4171";
    ABMultiValueAddValueAndLabel(aRecord, (CFStringRef) CFBridgingRetain(@"(203) 832-4171"), kABPersonPhoneMainLabel, NULL);
    ABMultiValueAddValueAndLabel(aRecord, (CFStringRef) CFBridgingRetain(@"(203) 832-4172"), kABPersonPhoneMobileLabel, NULL);
    ABMultiValueAddValueAndLabel(aRecord, (CFStringRef) CFBridgingRetain(@"(203) 832-4173"), kABOtherLabel, NULL);
    ABRecordSetValue(aRecord, kABPersonPhoneProperty, multiPhone,nil);
    
    CFStringRef firstName, lastName, company, email;
    firstName = ABRecordCopyValue(aRecord, kABPersonFirstNameProperty);
    lastName  = ABRecordCopyValue(aRecord, kABPersonLastNameProperty);
    
    
	CFErrorRef error = NULL;
    
    BOOL isAdded = ABAddressBookAddRecord (
                                           addressBook,
                                           aRecord,
                                           &error
                                           );
	if(isAdded){
		
		NSLog(@"added");
    }
    
    NSLog(@"hasUnsaved: %i", ABAddressBookHasUnsavedChanges(addressBook));

    bool didSave;
    if ( ABAddressBookHasUnsavedChanges(addressBook)) {
        didSave = ABAddressBookSave(addressBook, &error);
    }
    else {
        
    }
    
    
    /*ABRecordRef aRecord = ABPersonCreate();
    CFErrorRef anError = NULL;
    bool didSet;
    didSet = ABRecordSetValue(aRecord, kABPersonFirstNameProperty, CFSTR("Katie"),
                              &anError);
    if (!didSet) {/* Handle error here. }
    didSet = ABRecordSetValue(aRecord, kABPersonLastNameProperty, CFSTR("Bell"),
                              &anError);
    if (!didSet) {/* Handle error here. }
    CFStringRef firstName, lastName;
    firstName = ABRecordCopyValue(aRecord, kABPersonFirstNameProperty);
    lastName = ABRecordCopyValue(aRecord, kABPersonLastNameProperty);
    
    ABAddressBookRef addressBook;
	CFErrorRef error = NULL;
	addressBook = ABAddressBookCreate();
	
	BOOL isAdded = ABAddressBookAddRecord (
                                           addressBook,
                                           aRecord,
                                           &error
                                           );
	
	if(isAdded){
		
		NSLog(@"added");
              }
              if (error != NULL) {
                  NSLog(@"ABAddressBookAddRecord %@", error);
                        }
                        error = NULL;
                        
                        BOOL isSaved = ABAddressBookSave (
                                                          addressBook,
                                                          &error
                                                        r);
                        
                        if(isSaved){
                            
                            NSLog(@"saved..");
                                  }
                                  
                                  if (error != NULL) {
                                      NSLog(@"ABAddressBookSave %@", error);
                                            }
}*/

//Add profile
- (void) createUser {
    NSString *url = [NSString stringWithFormat:@"http://pennapps-2013s.herokuapp.com/services/pennapps/contact/%@/%@/%@/%@", _firstName.text, _lastName.text, _mobile.text, _email.text];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"POST"];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}


- (void)viewDidLoad
{
    [[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bglight.png"]]];
    UIImage *img=[UIImage imageNamed:@"profile.png"];
    [self.navigationController.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
    _firstName.returnKeyType = UIReturnKeyDone;
    _lastName.returnKeyType = UIReturnKeyDone;
    _company.returnKeyType = UIReturnKeyDone;
    _email.returnKeyType = UIReturnKeyDone;
    _mobile.returnKeyType = UIReturnKeyDone;

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _myContact = appDelegate.myContact;
    _firstName.text = _myContact.firstName;
    _lastName.text = _myContact.lastName;
    _company.text = _myContact.company;
    _email.text = _myContact.email;
    _mobile.text = _myContact.mobile;

    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (IBAction) doneButtonOnKeyboardPressed:(id)sender {
    [sender resignFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"viewDidAppear");


	CFErrorRef error = NULL;
	addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    if (error) {
        NSLog(@"error: %@", error);
    }
    ABAuthorizationStatus authStatus = ABAddressBookGetAuthorizationStatus();
    NSLog(@"authorization status: %i", authStatus);
    
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
        if (!granted) {
            NSLog(@"not granted");
        }
    });
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
