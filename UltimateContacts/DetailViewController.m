//
//  DetailViewController.m
//  Helping2
//
//  Created by Daniel Judd on 1/20/13.
//  Copyright (c) 2013 Daniel Judd. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }

}
- (IBAction)downloadContactInfo:(id)sender {
    NSString *url = [NSString stringWithFormat:@"http://pennapps-2013s.herokuapp.com/services/pennapps/retrieve/%@", _detailDescriptionLabel.text];
    NSLog([NSString stringWithFormat:@"our event: %@",_detailDescriptionLabel.text]);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
    NSLog(@"here2");
}

- (void)viewDidLoad
{
    [[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgdark.png"]]];
    UIImage *img=[UIImage imageNamed:@"bgdarkheader.png"];
    [self.navigationController.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
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

    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NSDictionary *myLocations = [NSJSONSerialization JSONObjectWithData:_data options:0 error:nil];
    NSLog(myLocations.description);
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:_data options:kNilOptions error:nil];
    for (NSDictionary* object in dictionary) {
        if (![object isEqual:[NSNull null]]) {
            NSString *firstName = [object objectForKey:@"first_name"];
            if (firstName)
                NSLog(firstName);
            NSString *lastName = [object objectForKey:@"last_name"];
            if (lastName)
                NSLog(lastName);
            NSString *email = [object objectForKey:@"email"];
            if (email)
                NSLog(email);
            NSString *phone = [object objectForKey:@"phone"];
            if (phone)
                NSLog(phone);
            
            NSLog(@"hello");
            CFErrorRef anError = NULL;
            ABRecordRef aRecord = ABPersonCreate();
            bool didSet;
            didSet = ABRecordSetValue(aRecord, kABPersonFirstNameProperty, (CFStringRef) CFBridgingRetain(firstName),
                                      &anError);
            if (!didSet) {/* Handle error here. */}
            didSet = ABRecordSetValue(aRecord, kABPersonLastNameProperty, (CFStringRef) CFBridgingRetain(lastName),
                                      &anError);
            
            ABMutableMultiValueRef multiEmail = ABMultiValueCreateMutable(kABMultiStringPropertyType);
            ABMultiValueAddValueAndLabel(multiEmail, (CFStringRef) CFBridgingRetain(email), kABWorkLabel, NULL);
            ABRecordSetValue(aRecord, kABPersonEmailProperty, multiEmail, &anError);
            CFRelease(multiEmail);
            /*if (email)
                didSet = ABRecordSetValue(aRecord, kABPersonEmailProperty, (CFStringRef) CFBridgingRetain(email), &anError);
            
            
 /*           ABMutableMultiValueRef multiPhone = ABMultiValueCreateMutable(kABMultiStringPropertyType);
            
             ABMultiValueAddValueAndLabel(aRecord, (CFStringRef) CFBridgingRetain(@"(203) 832-4171"), kABPersonPhoneMainLabel, NULL);
             ABMultiValueAddValueAndLabel(aRecord, (CFStringRef) CFBridgingRetain(@"(203) 832-4172"), kABPersonPhoneMobileLabel, NULL);
             ABMultiValueAddValueAndLabel(aRecord, (CFStringRef) CFBridgingRetain(@"(203) 832-4173"), kABOtherLabel, NULL);
             ABRecordSetValue(aRecord, kABPersonPhoneProperty, multiPhone,nil);*/
            
            //ABMultiValueRef multiPhones = ABRecordCopyValue(aRecord, kABPersonPhoneProperty);
            //ABMutableMultiValueRef multiPhone = ABMultiValueCreateMutableCopy(multiPhones);
            //ABMultiValueAddValueAndLabel(multiPhone, @"1111111111", kABOtherLabel ,NULL);
            
            /*ABMultiValueRef Phones = ABRecordCopyValue(aRecord, kABPersonPhoneProperty);
            ABMutableMultiValueRef Phone = ABMultiValueCreateMutableCopy(Phones);
            ABMultiValueAddValueAndLabel(Phone,@"413-675-1234", kABOtherLabel, NULL);
            ABMultiValueAddValueAndLabel(Phone, @"413-675-1235", kABOtherLabel, NULL);
            ABRecordSetValue(aRecord, kABPersonPhoneProperty, Phone,nil);*/
            
            ABMutableMultiValueRef multi =
            ABMultiValueCreateMutable(kABMultiStringPropertyType);
            ABMultiValueIdentifier multivalueIdentifier;
            bool didAdd;
            
            didAdd = ABMultiValueAddValueAndLabel(multi, (CFStringRef) CFBridgingRetain(phone),
                                                  kABPersonPhoneMobileLabel, &multivalueIdentifier);
            if (!didAdd) {/* Handle error here. */}
            
            //didAdd = ABMultiValueAddValueAndLabel(multi, @"(555) 555-2345",
                                                  //kABPersonPhoneMainLabel, &multivalueIdentifier);
            //if (!didAdd) {/* Handle error here. */}
            
            didSet = ABRecordSetValue(aRecord, kABPersonPhoneProperty, multi, &anError);
            if (!didSet) {/* Handle error here. */}
            
            /* ... */
            

        
            
            CFStringRef firstName1, lastName1, company, email1;
            firstName1 = ABRecordCopyValue(aRecord, kABPersonFirstNameProperty);
            lastName1  = ABRecordCopyValue(aRecord, kABPersonLastNameProperty);
            
            
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
             }*/
            
        }
    }
}


@end
