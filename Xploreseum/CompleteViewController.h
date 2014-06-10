//
//  CompleteViewController.h
//  Xploreseum
//
//  Created by taufiq on 5/15/14.
//  Copyright (c) 2014 SerembanMaya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompleteViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
@property (strong, nonatomic) IBOutlet UILabel *userMarksLbl;

@property (nonatomic,strong)UIImageView *image;
@property (strong, nonatomic) IBOutlet UIImageView *imageV;

- (IBAction)takePhoto:(id)sender;
@end
