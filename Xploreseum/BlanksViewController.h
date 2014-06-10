//
//  BlanksViewController.h
//  Xploreseum
//
//  Created by taufiq on 5/15/14.
//  Copyright (c) 2014 SerembanMaya. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataTable,DBController;
@interface BlanksViewController : UIViewController<UIAlertViewDelegate>{
    UIBarButtonItem *btnDone;
}

@property (strong, nonatomic) DBController* db;
@property (strong, nonatomic) DataTable* question_table;

@property (strong, nonatomic) NSString *answer;
@property (strong, nonatomic) IBOutlet UILabel *questionLbl;
@property (strong, nonatomic) IBOutlet UITextField *userAnswertxt;
@property (strong, nonatomic) IBOutlet UILabel *questionNumberLbl;


@end
