//
//  locDetailViewController.h
//  Xploreseum
//
//  Created by taufiq on 6/11/14.
//  Copyright (c) 2014 SerembanMaya. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DataTable,DBController;
@interface locDetailViewController : UIViewController
{
    BOOL inLocation;
}



@property (strong, nonatomic) DBController* db;
@property (strong, nonatomic) DataTable* table;
@property (strong, nonatomic) DataTable* Questiontable;

@property (strong, nonatomic) NSString *locID;

@property (strong, nonatomic) IBOutlet UITextView *textViewMuseum;
@property (strong, nonatomic) IBOutlet UILabel *status;
@property (strong, nonatomic) IBOutlet UIImageView *imgViewMuseum;

@property (strong, nonatomic) IBOutlet UIButton *startBtn;

- (IBAction)actionStart:(id)sender;
@end
