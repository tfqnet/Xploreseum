//
//  ImageBlanksViewController.h
//  Xploreseum
//
//  Created by taufiq on 5/14/14.
//  Copyright (c) 2014 SerembanMaya. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataTable,DBController;
@interface ImageBlanksViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>{
    UIBarButtonItem *btnDone;
}


@property (strong, nonatomic) DBController* db;
@property (strong, nonatomic) DataTable* question_table;

@property (strong, nonatomic) IBOutlet UIImageView *questionImage;
@property (strong, nonatomic) IBOutlet UITextField *UserAnswerTxtField;
@property (strong, nonatomic) NSString *imgName;
@property (strong, nonatomic) NSString *answer;

@property (strong, nonatomic) IBOutlet UILabel *questionNumberLbl;
@end
