//
//  beforeShareViewController.h
//  Xploreseum
//
//  Created by taufiq on 5/19/14.
//  Copyright (c) 2014 SerembanMaya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface beforeShareViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>{
    SLComposeViewController *mySLComposerSheet;
    UIBarButtonItem *home;
}


@property (nonatomic,strong)UIImageView *image;
@property (strong, nonatomic) UIImageView *tempImage;


@property (nonatomic, assign) BOOL isphoto;
@property (nonatomic, assign) BOOL isshare;

@property (strong, nonatomic) IBOutlet UIImageView *resultImg;
- (IBAction)share:(id)sender;
@end
