//
//  RegisterViewController.h
//  Xploreseum
//
//  Created by taufiq on 6/3/14.
//  Copyright (c) 2014 SerembanMaya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface RegisterViewController : UIViewController<MBProgressHUDDelegate>{
    MBProgressHUD *HUD;
}


@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *email;

@property (strong, nonatomic) IBOutlet UITextField *verifyPassword;


- (IBAction)registerBtn:(id)sender;

@end
