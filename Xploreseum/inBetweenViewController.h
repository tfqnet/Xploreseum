//
//  inBetweenViewController.h
//  Xploreseum
//
//  Created by taufiq on 5/22/14.
//  Copyright (c) 2014 SerembanMaya. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DataTable,DBController;
@interface inBetweenViewController : UIViewController<UIActionSheetDelegate>

@property (strong, nonatomic) DBController* db;
@property (strong, nonatomic) DataTable* table;


@property (strong, nonatomic) IBOutlet UILabel *resultLbl;

@property (nonatomic, assign) BOOL isCorrect;
@property (nonatomic, assign) BOOL isSkip;

@property (strong, nonatomic) IBOutlet UILabel *statusLbl;

@property (strong, nonatomic) IBOutlet UIButton *btnOutlet;

- (IBAction)proceed:(id)sender;


@end
