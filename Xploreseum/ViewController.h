//
//  ViewController.h
//  Xploreseum
//
//  Created by taufiq on 5/12/14.
//  Copyright (c) 2014 SerembanMaya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<NSURLConnectionDelegate,UIAlertViewDelegate>{
       
   
    
    NSMutableData *imageData;
}

@property (strong, nonatomic) IBOutlet UIImageView *profileImg;
@property (strong, nonatomic) IBOutlet UILabel *nameLbl;
@end
