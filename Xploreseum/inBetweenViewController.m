//
//  inBetweenViewController.m
//  Xploreseum
//
//  Created by taufiq on 5/22/14.
//  Copyright (c) 2014 SerembanMaya. All rights reserved.
//

#import "inBetweenViewController.h"
#import "AppDelegate.h"
#import "DataTable.h"
#import "DBController.h"

#import "MultipleChoiceViewController.h"
#import "BlanksViewController.h"
#import "ImageBlanksViewController.h"
#import "beforeShareViewController.h"

#import "CompleteViewController.h"


@interface inBetweenViewController ()

@end

@implementation inBetweenViewController

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
    
    if (_isCorrect) {
        _resultLbl.text = @"Congratulations, your answer is correct";
    }
    else
        _resultLbl.text = @"Sorry, your answer is incorrect";
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    
    if([appDelegate.currentQuestionIndex intValue]==10){
        NSString *text = [NSString stringWithFormat:@"You have completed the quest"];
        
        
        _statusLbl.text = text;
    }
    
    
    self.db = [DBController sharedDatabaseController:@"xploreseumDB.sqlite"];
    
    
    NSString *str = [NSString stringWithFormat:@"SELECT * from question_tbl where id = '%@'",appDelegate.currentQuestionIndex];
    
    _table = [_db ExecuteQuery:str];
    
    
    // Do any additional setup after loading the view.
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

- (IBAction)proceed:(id)sender {
    
     AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if ([appDelegate.currentQuestionIndex intValue]==10) {
        [self complete];
    }
    else{
        int value = [appDelegate.currentQuestionIndex intValue];
        appDelegate.currentQuestionIndex = [NSNumber numberWithInt:value+1];
        
        NSString *str = [NSString stringWithFormat:@"SELECT * from question_tbl where id = '%@'",appDelegate.currentQuestionIndex];
        
        _table = [_db ExecuteQuery:str];
        
        
        
        for(NSArray* row in _table.rows){
            
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
    
    
    
}

-(void)complete{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
   
    CompleteViewController *complete = [storyboard instantiateViewControllerWithIdentifier:@"complete"];
    
    
    
    [self.navigationController pushViewController:complete animated:YES];

    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
   
}


@end








