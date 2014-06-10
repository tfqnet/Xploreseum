//
//  loginViewController.m
//  Xploreseum
//
//  Created by taufiq on 6/1/14.
//  Copyright (c) 2014 SerembanMaya. All rights reserved.
//

#import "loginViewController.h"
#import "ViewController.h"
#import "MBProgressHUD.h"
#import "RegisterViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import <Parse/Parse.h>

@interface loginViewController ()

@end

@implementation loginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:HUD];
    HUD.dimBackground = YES;
	
	// Regiser for HUD callbacks so we can remove it from the window at the right time
	HUD.delegate = self;
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg640x1008.png"]];
    [backgroundView setFrame:CGRectMake(0, 0, 320, 568)];
    [self.view insertSubview:backgroundView atIndex:0];    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [HUD hide:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(BOOL)validate{
    
    if([_username.text isEqualToString:@""]){
        return NO;
    }
    
    if ([_password.text isEqualToString:@""]) {
        return NO;
    }
    
    return YES;
}

- (IBAction)signInBtn:(id)sender {
    
    [HUD show:YES];
    if ([self validate]) {
        
        [PFUser logInWithUsernameInBackground:_username.text password:_password.text
                                        block:^(PFUser *user, NSError *error) {
                                            if (user) {
                                                [self dismissViewControllerAnimated:YES completion:nil];
                                            } else {
                                                [HUD hide:YES];
                                                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Login error" message:@"Wrong username/password. Try again" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                                                [alert show];

                                            }
                                        }];

    }
    else
    {
        [HUD hide:YES];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Login error" message:@"username/password cannot be empty" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }
    
}

- (IBAction)registerBtn:(id)sender {
    
    //UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //RegisterViewController *reg = [storyboard instantiateViewControllerWithIdentifier:@"register"];
    //[self.navigationController pushViewController:reg animated:YES];
}

- (IBAction)btnAction:(id)sender {
    
       NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
    
    // Login PFUser using Facebook
    [HUD show:YES];
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        
        if (!user) {
            if (!error) {
                [HUD hide:YES];
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
            } else {
                [HUD hide:YES];
                NSLog(@"Uh oh. An error occurred: %@", error);
            }
        } else if (user.isNew) {
            [HUD hide:YES];
            NSLog(@"User with facebook signed up and logged in!");
            [self dismissViewControllerAnimated:YES completion:nil];
            
        } else {
            [HUD hide:YES];
            NSLog(@"User with facebook logged in!");
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }
    }];
    
    // Login PFUser using Facebook
  }
@end
