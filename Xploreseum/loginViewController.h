//
//  loginViewController.h
//  Xploreseum
//
//  Created by taufiq on 6/1/14.
//  Copyright (c) 2014 SerembanMaya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface loginViewController : UIViewController<MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
}


@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;

- (IBAction)signInBtn:(id)sender;
- (IBAction)registerBtn:(id)sender;

- (IBAction)btnAction:(id)sender;
@end
