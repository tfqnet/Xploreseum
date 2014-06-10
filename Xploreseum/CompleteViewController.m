//
//  CompleteViewController.m
//  Xploreseum
//
//  Created by taufiq on 5/15/14.
//  Copyright (c) 2014 SerembanMaya. All rights reserved.
//

#import "CompleteViewController.h"
#import "AppDelegate.h"
#import "beforeShareViewController.h"

@interface CompleteViewController ()

@end

@implementation CompleteViewController

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
    
    [self.navigationItem setHidesBackButton:YES];
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg640x1008.png"]];
    [backgroundView setFrame:CGRectMake(0, 0, 320, 568)];
    [self.view insertSubview:backgroundView atIndex:0];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    NSString *str = [NSString stringWithFormat:@"You score %ld/10",(long)appDelegate.usermarks];
    

    
    _userMarksLbl.text = str;     // Do any additional setup after loading the view.
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

- (IBAction)takePhoto:(id)sender {
   
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Select option:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Camera",
                            @"Library",
                            nil];
    
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
    
    /*
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    beforeShareViewController *before = [storyboard instantiateViewControllerWithIdentifier:@"before"];
     [self.navigationController pushViewController:before animated:YES];
    */

    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    beforeShareViewController *before = [storyboard instantiateViewControllerWithIdentifier:@"before"];
    
    if (buttonIndex==0){
        before.isphoto = YES;
        [self.navigationController pushViewController:before animated:YES];
    }
    else if (buttonIndex==1){
        [self.navigationController pushViewController:before animated:YES];

    }
    
    
    
    

    
}




@end
