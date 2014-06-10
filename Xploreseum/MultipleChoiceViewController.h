//
//  MultipleChoiceViewController.h
//  Xploreseum
//
//  Created by taufiq on 5/14/14.
//  Copyright (c) 2014 SerembanMaya. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataTable,DBController;
@interface MultipleChoiceViewController : UIViewController<UIGestureRecognizerDelegate,UIAlertViewDelegate>{
    UIBarButtonItem *btnDone;
}

@property (strong, nonatomic) DBController* db;
@property (strong, nonatomic) DataTable* question_table;
@property (strong, nonatomic) DataTable* answer_table;

@property (strong, nonatomic) IBOutlet UIView *optionA;

@property (strong, nonatomic) IBOutlet UIView *optionB;

@property (strong, nonatomic) IBOutlet UIView *optionC;

@property (strong, nonatomic) IBOutlet UIView *optionD;

@property (strong, nonatomic) IBOutlet UILabel *lblA;
@property (strong, nonatomic) IBOutlet UILabel *lblB;
@property (strong, nonatomic) IBOutlet UILabel *lblC;
@property (strong, nonatomic) IBOutlet UILabel *lblD;
@property (strong, nonatomic) IBOutlet UILabel *lblQuestion;

@property (nonatomic, assign) NSInteger iIndex;

@property (nonatomic, strong) NSString *answer;
@property (nonatomic, strong) NSString *tempUserAnswer;
@property (strong, nonatomic) IBOutlet UILabel *questionnumberLbl;
@property (strong, nonatomic) IBOutlet UIImageView *imgA;
@property (strong, nonatomic) IBOutlet UIImageView *imgB;
@property (strong, nonatomic) IBOutlet UIImageView *imgC;
@property (strong, nonatomic) IBOutlet UIImageView *imgD;


- (IBAction)gestureA:(id)sender;
- (IBAction)gestureB:(id)sender;

- (IBAction)gestureC:(id)sender;
- (IBAction)gestureD:(id)sender;


@end
