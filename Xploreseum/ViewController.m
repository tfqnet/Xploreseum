//
//  ViewController.m
//  Xploreseum
//
//  Created by taufiq on 5/12/14.
//  Copyright (c) 2014 SerembanMaya. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>
#import "loginViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import <SDWebImage/UIImageView+WebCache.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    FBRequest *request = [FBRequest requestForMe];
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            // handle successful response
        } else if ([error.userInfo[FBErrorParsedJSONResponseKey][@"body"][@"error"][@"type"] isEqualToString:@"OAuthException"]) { // Since the request failed, we can check if it was due to an invalid session
            NSLog(@"The facebook session was invalidated");
            [self sessionTimedout];
        } else {
            NSLog(@"Some other error: %@", error);
        }
    }];
   
    
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];

    
    UIImage* image = [UIImage imageNamed:@"btnotherbtm.png"];
    CGRect frame = CGRectMake(0, 0, 45, 40);
    UIButton* someButton = [[UIButton alloc] initWithFrame:frame];
    [someButton setBackgroundImage:image forState:UIControlStateNormal];
    [someButton setTitle:@"Logout" forState:UIControlStateNormal];
    someButton.titleLabel.font = [UIFont fontWithName:@"IowanOldStyle-Bold" size:12];
    [someButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//[UIColor colorWithRed:79.0/255.0 green:38.0/255.0 blue:9.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(home) forControlEvents:UIControlEventTouchDown];
    
    [someButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem* someBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:someButton];
    [self.navigationItem setLeftBarButtonItem:someBarButtonItem];
    
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg640x1008.png"]];
    [backgroundView setFrame:CGRectMake(0, 0, 320, 568)];
    [self.view insertSubview:backgroundView atIndex:0];	// Do any additional setup after loading the view, typically from a nib.
    
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if([PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]){
        FBRequest *request = [FBRequest requestForMe];
        
        // Send request to Facebook
        [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
            if (!error) {
                // result is a dictionary with the user's Facebook data
                NSDictionary *userData = (NSDictionary *)result;
                NSLog(@"userdata: %@",userData);
                
                
                NSString *ifacebookID = userData[@"id"];
                NSString *iname = userData[@"name"];
                
                NSString *iemail = userData[@"email"];
                
                
                imageData = [[NSMutableData alloc] init];
                NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", ifacebookID]];
                
                NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:pictureURL
                                                                          cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                                      timeoutInterval:2.0f];
                
               // NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
                
                
                
                _nameLbl.text = [NSString stringWithFormat:@"Hi, %@",iname];
                
                PFUser *user = [PFUser currentUser];
                user.username = iname;
                user[@"email"] = iemail;
                [user save];
                
                
                
                
                
            }
        }];

    }
    else if ([PFUser currentUser])
    {
        PFUser *user = [PFUser currentUser];
        _nameLbl.text = [NSString stringWithFormat:@"Hi, %@",user.username];
        [_profileImg setImage:[UIImage imageNamed:@"profile_placeholder.gif"]];
    }
    else
    {
        loginViewController *login = [storyboard instantiateViewControllerWithIdentifier:@"login"];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:login];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }

}

-(void)sessionTimedout{

    [PFUser logOut]; // Log out
    
    // Return to login page
    [self.navigationController popToRootViewControllerAnimated:YES];

}

-(void)home{
    UIAlertView *logout = [[UIAlertView alloc]initWithTitle:@"Logout" message:@"Are you sure to logout?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
    
    [logout show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==1) {
        [PFUser logOut]; // Log out
        
        // Return to login page
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        loginViewController *login = [storyboard instantiateViewControllerWithIdentifier:@"login"];
        [self.navigationController presentViewController:login animated:YES completion:nil];
    }
}


// Called every time a chunk of the data is received
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [imageData appendData:data]; // Build the image
}

// Called when the entire image is finished downloading
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // Set the image in the header imageView
    _profileImg.image = [UIImage imageWithData:imageData];
    
    }


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
