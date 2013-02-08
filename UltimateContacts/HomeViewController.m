//
//  HomeViewController.m
//  UltimateContacts
//
//  Created by Daniel Judd on 1/19/13.
//  Copyright (c) 2013 Daniel Judd. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    UIImage *img=[UIImage imageNamed:@"home.png"];
    [self.navigationController.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
}

-(void)viewDidAppear:(BOOL)animated {
    [[self view] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    UIImage *img=[UIImage imageNamed:@"home.png"];
    [self.navigationController.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end