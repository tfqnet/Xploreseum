//
//  BlanksViewController.m
//  Xploreseum
//
//  Created by taufiq on 5/15/14.
//  Copyright (c) 2014 SerembanMaya. All rights reserved.
//

#import "BlanksViewController.h"
#import "AppDelegate.h"
#import "MultipleChoiceViewController.h"
#import "ImageBlanksViewController.h"
#import "DataTable.h"
#import "DBController.h"
#import "CompleteViewController.h"
#import "inBetweenViewController.h"

@interface BlanksViewController ()

@end

@implementation BlanksViewController

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
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg640x1008.png"]];
    [backgroundView setFrame:CGRectMake(0, 0, 320, 568)];
    [self.view insertSubview:backgroundView atIndex:0];
    
    
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.navigationItem.title = [NSString stringWithFormat:@"Question %@/10",appDelegate.currentQuestionIndex];
    
   // _questionNumberLbl.text = [NSString stringWithFormat:@"Question %@/10",appDelegate.currentQuestionIndex];

    UIImage* imageright = [UIImage imageNamed:@"btnnextbtm.png"];
    CGRect frameright = CGRectMake(0, 0, 45, 40);
    UIButton* someButtonright = [[UIButton alloc] initWithFrame:frameright];
    [someButtonright setBackgroundImage:imageright forState:UIControlStateNormal];
    [someButtonright setTitle:@"Next" forState:UIControlStateNormal];
    someButtonright.titleLabel.font = [UIFont fontWithName:@"IowanOldStyle-Bold" size:12];
    [someButtonright setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//[UIColor colorWithRed:79.0/255.0 green:38.0/255.0 blue:9.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [someButtonright addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchDown];
    
    [someButtonright setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem* someBarButtonItemRight = [[UIBarButtonItem alloc] initWithCustomView:someButtonright];
    [self.navigationItem setRightBarButtonItem:someBarButtonItemRight];
    
    
    
    
    UIImage* image = [UIImage imageNamed:@"btnbackbtm.png"];
    CGRect frame = CGRectMake(0, 0, 45, 40);
    UIButton* someButton = [[UIButton alloc] initWithFrame:frame];
    [someButton setBackgroundImage:image forState:UIControlStateNormal];
    [someButton setTitle:@" Home" forState:UIControlStateNormal];
    someButton.titleLabel.font = [UIFont fontWithName:@"IowanOldStyle-Bold" size:12];
    [someButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//[UIColor colorWithRed:79.0/255.0 green:38.0/255.0 blue:9.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(home) forControlEvents:UIControlEventTouchDown];
    
    [someButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem* someBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:someButton];
    [self.navigationItem setLeftBarButtonItem:someBarButtonItem];

    
    
    
    
   

    
    self.db = [DBController sharedDatabaseController:@"xploreseumDB.sqlite"];
    
    
    NSString *str = [NSString stringWithFormat:@"SELECT * from question_tbl where id = '%@'",appDelegate.currentQuestionIndex];
    
    _question_table = [_db ExecuteQuery:str];
    
    for(NSArray* row in _question_table.rows){
        
        _questionLbl.text = [row objectAtIndex:1];
        _answer = _answer = [row objectAtIndex:2];
        
    }
    // Do any additional setup after loading the view.
}

-(void)home
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Xploreseum" message:@"Are you to exit? current progress will be deleted" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
    [alert show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        [self.navigationController popToRootViewControllerAnimated:YES];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.currentQuestionIndex=0;
    }
}

-(void)next
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    inBetweenViewController *next = [storyboard instantiateViewControllerWithIdentifier:@"next"];
    
    if([_userAnswertxt.text isEqualToString:_answer]){
        NSLog(@"correct");
        appDelegate.usermarks=appDelegate.usermarks+1;
        next.isCorrect = YES;
    }
    else
        NSLog(@"wrong");
    
    
    
    
    [self.navigationController pushViewController:next animated:YES];
    
   
    
    }

-(void)complete{
     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CompleteViewController *complete = [storyboard instantiateViewControllerWithIdentifier:@"complete"];
    [self.navigationController pushViewController:complete animated:YES];
    
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
