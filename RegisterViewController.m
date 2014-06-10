//
//  RegisterViewController.m
//  Xploreseum
//
//  Created by taufiq on 6/3/14.
//  Copyright (c) 2014 SerembanMaya. All rights reserved.
//

#import "RegisterViewController.h"
#import <Parse/Parse.h>

@interface RegisterViewController ()

@end

@implementation RegisterViewController

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
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:HUD];
    HUD.dimBackground = YES;
	
	// Regiser for HUD callbacks so we can remove it from the window at the right time
	HUD.delegate = self;
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    
    UIImage* image = [UIImage imageNamed:@"btnbackbtm.png"];
    CGRect frame = CGRectMake(0, 0, 45, 40);
    UIButton* someButton = [[UIButton alloc] initWithFrame:frame];
    [someButton setBackgroundImage:image forState:UIControlStateNormal];
    [someButton setTitle:@" Back" forState:UIControlStateNormal];
    someButton.titleLabel.font = [UIFont fontWithName:@"IowanOldStyle-Bold" size:12];
    [someButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//[UIColor colorWithRed:79.0/255.0 green:38.0/255.0 blue:9.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(btnPressed) forControlEvents:UIControlEventTouchDown];
    
    [someButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem* someBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:someButton];
    [self.navigationItem setLeftBarButtonItem:someBarButtonItem];
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg640x1008.png"]];
    [backgroundView setFrame:CGRectMake(0, 0, 320, 568)];
    [self.view insertSubview:backgroundView atIndex:0];
    // Do any additional setup after loading the view.
}
-(void)btnPressed{
    
    [self.navigationController popViewControllerAnimated:YES];
    
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

-(BOOL)validateText{
    
    if([_username.text isEqualToString:@""]&&[_password.text isEqualToString:@""]&&[_verifyPassword.text isEqualToString:@""]&&[_email.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Textfield cannot be empty" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        [HUD hide:YES];
        return NO;
        
    }
    if(![_password.text isEqualToString:_verifyPassword.text]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"password does not match" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        [HUD hide:YES];
        return NO;
    }
    
    
    return  YES;
}

- (IBAction)registerBtn:(id)sender {
    
    [HUD show:YES];
    
    if([self validateText]){
        PFUser *user = [PFUser user];
        user.username = _username.text;
        user.password = _password.text;
        user.email = _email.text;
        
        // other fields can be set just like with PFObject
        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
            } else {
                NSString *errorString = [error userInfo][@"error"];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:errorString delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alert show];
                [HUD hide:YES];
                
            }
        }];
    }
    
   
}
@end
