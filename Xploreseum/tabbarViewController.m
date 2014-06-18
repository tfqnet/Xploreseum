//
//  tabbarViewController.m
//  Xploreseum
//
//  Created by taufiq on 6/17/14.
//  Copyright (c) 2014 SerembanMaya. All rights reserved.
//

#import "tabbarViewController.h"

@interface tabbarViewController ()

@end

@implementation tabbarViewController

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
    
    
    [self.tabBarController.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.tabBarController.navigationController.navigationBar.shadowImage = [UIImage new];
    self.tabBarController.navigationController.navigationBar.translucent = YES;
    self.tabBarController.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationItem.hidesBackButton =YES;
    // Do any additional setup after loading the view.
    
    UIImage* image = [UIImage imageNamed:@"btnbackbtm.png"];
    CGRect frame = CGRectMake(0, 0, 45, 40);
    UIButton* someButton = [[UIButton alloc] initWithFrame:frame];
    [someButton setBackgroundImage:image forState:UIControlStateNormal];
    [someButton setTitle:@" Back" forState:UIControlStateNormal];
    someButton.titleLabel.font = [UIFont fontWithName:@"IowanOldStyle-Bold" size:12];
    [someButton setTitleColor:[UIColor colorWithRed:79.0/255.0 green:38.0/255.0 blue:9.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(btnPressed) forControlEvents:UIControlEventTouchDown];
    
    [someButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem* someBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:someButton];
    [self.navigationItem setLeftBarButtonItem:someBarButtonItem];
}

-(void)btnPressed{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
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

@end
