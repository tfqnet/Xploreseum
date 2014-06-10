//
//  MultipleChoiceViewController.m
//  Xploreseum
//
//  Created by taufiq on 5/14/14.
//  Copyright (c) 2014 SerembanMaya. All rights reserved.
//

#import "MultipleChoiceViewController.h"
#import "AppDelegate.h"
#import "DataTable.h"
#import "DBController.h"
#import "ImageBlanksViewController.h"
#import "BlanksViewController.h"
#import "CompleteViewController.h"
#import "inBetweenViewController.h"

@interface MultipleChoiceViewController ()

@end

@implementation MultipleChoiceViewController

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
    
   // _questionnumberLbl.text = [NSString stringWithFormat:@"Question %@/10",appDelegate.currentQuestionIndex];

    self.navigationItem.title = [NSString stringWithFormat:@"Question %@/10",appDelegate.currentQuestionIndex];
    
    
    
    [_imgA setImage:[UIImage imageNamed:@"answer.png"]];
    [_imgB setImage:[UIImage imageNamed:@"answer.png"]];
    [_imgC setImage:[UIImage imageNamed:@"answer.png"]];
    [_imgD setImage:[UIImage imageNamed:@"answer.png"]];
    
    
    
        
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
    

    
    
    _lblQuestion.adjustsFontSizeToFitWidth = YES;
    
    
    
    
    self.db = [DBController sharedDatabaseController:@"xploreseumDB.sqlite"];
    
    
    NSString *str = [NSString stringWithFormat:@"SELECT * from question_tbl where id = '%@'",appDelegate.currentQuestionIndex];
    
    _question_table = [_db ExecuteQuery:str];
    
    for (NSArray* row in _question_table.rows) {
        
        
        _lblQuestion.text = [row objectAtIndex:1];
        _answer = [NSString stringWithFormat:@"%@",[row objectAtIndex:2]];
        
        
        
        NSString *str2 = [NSString stringWithFormat:@"SELECT * from answer_tbl where parent_id = '%@'",[row objectAtIndex:0]];
        _answer_table = [_db ExecuteQuery:str2];
        
        
        
        
        
    }
    for(NSArray* row in _answer_table.rows){
        _lblA.text = [NSString stringWithFormat:@"%@",[row objectAtIndex:2]];
        _lblB.text = [NSString stringWithFormat:@"%@",[row objectAtIndex:3]];
        _lblC.text = [NSString stringWithFormat:@"%@",[row objectAtIndex:4]];
        _lblD.text = [NSString stringWithFormat:@"%@",[row objectAtIndex:5]];
    }

    
    
  }



-(void)next{
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    inBetweenViewController *next = [storyboard instantiateViewControllerWithIdentifier:@"next"];
    
    if ([_tempUserAnswer isEqualToString:_answer]) {
        NSLog(@"Correct Answer!");
        appDelegate.usermarks = appDelegate.usermarks+1;
         next.isCorrect = YES;
    }
    else
        NSLog(@"Wrong Answer!");
    
    
    
   
    [self.navigationController pushViewController:next animated:YES];
    
    /*
    int value = [appDelegate.currentQuestionIndex intValue];
    appDelegate.currentQuestionIndex = [NSNumber numberWithInt:value+1];
    
    NSString *str = [NSString stringWithFormat:@"SELECT * from question_tbl where id = '%@'",appDelegate.currentQuestionIndex];
    DataTable *dt = [_db ExecuteQuery:str];
    
    
    
    
    
    for(NSArray* row in dt.rows){
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

    */
}

-(void)home{
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


- (IBAction)gestureA:(id)sender {
    NSLog(@"tap A");
    
    
    [_imgA setImage:[UIImage imageNamed:@"answerselect.png"]];
    [_imgB setImage:[UIImage imageNamed:@"answer.png"]];
    [_imgC setImage:[UIImage imageNamed:@"answer.png"]];
    [_imgD setImage:[UIImage imageNamed:@"answer.png"]];
   

    
    _tempUserAnswer = _lblA.text;
}

- (IBAction)gestureB:(id)sender {
    NSLog(@"tap B");
    
    [_imgA setImage:[UIImage imageNamed:@"answer.png"]];
    [_imgB setImage:[UIImage imageNamed:@"answerselect.png"]];
    [_imgC setImage:[UIImage imageNamed:@"answer.png"]];
    [_imgD setImage:[UIImage imageNamed:@"answer.png"]];

    _tempUserAnswer = _lblB.text;
}

- (IBAction)gestureC:(id)sender {
    NSLog(@"tap C");
    
    [_imgA setImage:[UIImage imageNamed:@"answer.png"]];
    [_imgB setImage:[UIImage imageNamed:@"answer.png"]];
    [_imgC setImage:[UIImage imageNamed:@"answerselect.png"]];
    [_imgD setImage:[UIImage imageNamed:@"answer.png"]];
    _tempUserAnswer = _lblC.text;
}

- (IBAction)gestureD:(id)sender {
    NSLog(@"tap D");
    
    [_imgA setImage:[UIImage imageNamed:@"answer.png"]];
    [_imgB setImage:[UIImage imageNamed:@"answer.png"]];
    [_imgC setImage:[UIImage imageNamed:@"answer.png"]];
    [_imgD setImage:[UIImage imageNamed:@"answerselect.png"]];
    
    _tempUserAnswer = _lblD.text;
}
@end