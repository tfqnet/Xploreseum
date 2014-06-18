//
//  locDetailViewController.m
//  Xploreseum
//
//  Created by taufiq on 6/11/14.
//  Copyright (c) 2014 SerembanMaya. All rights reserved.
//

#import "locDetailViewController.h"
#import "DataTable.h"
#import "DBController.h"
#import "MultipleChoiceViewController.h"
#import "ImageBlanksViewController.h"
#import "BlanksViewController.h"
#import "CompleteViewController.h"
#import "AppDelegate.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface locDetailViewController ()

@end

@implementation locDetailViewController

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
    
    //temp
    //_locID = @"2";
    NSLog(@"locID %@",_locID);
    self.db = [DBController sharedDatabaseController:@"xploreseumDB.sqlite"];
    NSString *str  = [NSString stringWithFormat:@"SELECT * from location_tbl where status='yes' and id = %d",_locID.intValue];
    
    _table = [_db ExecuteQuery:str];
    NSLog(@"databaseloc %@",_table.rows);
    
    
    self.navigationItem.hidesBackButton =YES;
    
    for(NSArray *row in _table.rows){
        if([[row objectAtIndex:6]floatValue]<50){
            _status.text = @"Status: You are at location";
            inLocation=YES;
        }
        else if ([[row objectAtIndex:6]floatValue]<2000){
            _status.text = @"Status: You are nearby location";
        }
        else{
            _status.text = @"Not in location";
        }
        
        _textViewMuseum.text = [row objectAtIndex:7];
        
        [_imgViewMuseum setImage:[UIImage imageNamed:[row objectAtIndex:5]]];
    }
    
    
   
    
    
    
    
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
   
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg640x1008.png"]];
    [backgroundView setFrame:CGRectMake(0, 0, 320, 568)];
    [self.view insertSubview:backgroundView atIndex:0];
    
    
    UIImage* imager = [UIImage imageNamed:@"btnbackbtm.png"];
    CGRect framer = CGRectMake(0, 0, 45, 40);
    UIButton* someButtonr = [[UIButton alloc] initWithFrame:framer];
    [someButtonr setBackgroundImage:imager forState:UIControlStateNormal];
    [someButtonr setTitle:@" Back" forState:UIControlStateNormal];
    someButtonr.titleLabel.font = [UIFont fontWithName:@"IowanOldStyle-Bold" size:12];
    [someButtonr setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//[UIColor colorWithRed:79.0/255.0 green:38.0/255.0 blue:9.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [someButtonr addTarget:self action:@selector(btnPressed) forControlEvents:UIControlEventTouchDown];
    
    [someButtonr setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem* someBarButtonItemr = [[UIBarButtonItem alloc] initWithCustomView:someButtonr];
    [self.navigationItem setLeftBarButtonItem:someBarButtonItemr];

    
    /*
    UIImage* image = [UIImage imageNamed:@"btnotherbtm.png"];
    CGRect frame = CGRectMake(0, 0, 45, 40);
    UIButton* someButton = [[UIButton alloc] initWithFrame:frame];
    [someButton setBackgroundImage:image forState:UIControlStateNormal];
    [someButton setTitle:@" Back" forState:UIControlStateNormal];
    someButton.titleLabel.font = [UIFont fontWithName:@"IowanOldStyle-Bold" size:12];
    [someButton setTitleColor:[UIColor colorWithRed:79.0/255.0 green:38.0/255.0 blue:9.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(btnPressed) forControlEvents:UIControlEventTouchDown];
    
    [someButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem* someBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:someButton];
    [self.navigationItem setRightBarButtonItem:someBarButtonItem];
    */
    // Do any additional setup after loading the view.
}


- (IBAction)actionStart:(id)sender {
    [self start];
}


-(void)btnPressed{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}




-(void)start{
    //UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //CompleteViewController *complete = [storyboard instantiateViewControllerWithIdentifier:@"complete"];
    //[self.navigationController pushViewController:complete animated:YES];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.currentQuestionIndex = [NSNumber numberWithInt:1];
    
    //self.db = [DBController sharedDatabaseController:@"xploreseumDB.sqlite"];
    
    
    NSString *str = [NSString stringWithFormat:@"SELECT * from question_tbl where id = '%@'",appDelegate.currentQuestionIndex];
    
    _Questiontable = [_db ExecuteQuery:str];
    
    for(NSArray *row in _table.rows){
        [[NSUserDefaults standardUserDefaults] setObject:[row objectAtIndex:1] forKey:@"location"];
        NSLog(@"location %@",[row objectAtIndex:1]);
    }
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    
    
    for(NSArray* row in _Questiontable.rows)
    {
        if ([[row objectAtIndex:3]isEqualToString:@"mcq"]) {
            
            MultipleChoiceViewController *mcq = [storyboard instantiateViewControllerWithIdentifier:@"mcq"];
            [self.navigationController pushViewController:mcq animated:YES];
            
            
        }
        else if ([[row objectAtIndex:3]isEqualToString:@"blanks"]){
            BlanksViewController *blanks = [storyboard instantiateViewControllerWithIdentifier:@"blanks"];
            [self.navigationController pushViewController:blanks animated:YES];
                    }
        else if ([[row objectAtIndex:3]isEqualToString:@"image_blanks"]){
            
            ImageBlanksViewController *imgblank = [storyboard instantiateViewControllerWithIdentifier:@"imgBlank"];
            [self.navigationController pushViewController:imgblank animated:YES];
                        
        }
        
    }
    
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
