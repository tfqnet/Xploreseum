//
//  beforeShareViewController.m
//  Xploreseum
//
//  Created by taufiq on 5/19/14.
//  Copyright (c) 2014 SerembanMaya. All rights reserved.
//

#import "beforeShareViewController.h"
#import "AppDelegate.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface beforeShareViewController ()

@end

@implementation beforeShareViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg640x1008.png"]];
    [backgroundView setFrame:CGRectMake(0, 0, 320, 568)];
    [self.view insertSubview:backgroundView atIndex:0];
    
    UIImage* imageright = [UIImage imageNamed:@"btnotherbtm.png"];
    CGRect frameright = CGRectMake(0, 0, 45, 40);
    UIButton* someButtonright = [[UIButton alloc] initWithFrame:frameright];
    [someButtonright setBackgroundImage:imageright forState:UIControlStateNormal];
    [someButtonright setTitle:@"Home" forState:UIControlStateNormal];
    someButtonright.titleLabel.font = [UIFont fontWithName:@"IowanOldStyle-Bold" size:12];
    [someButtonright setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//[UIColor colorWithRed:79.0/255.0 green:38.0/255.0 blue:9.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [someButtonright addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchDown];
    
    [someButtonright setShowsTouchWhenHighlighted:YES];
    
    home = [[UIBarButtonItem alloc] initWithCustomView:someButtonright];
    
    [self.navigationItem setRightBarButtonItem:home];
    
    
    
    
    UIImage* image = [UIImage imageNamed:@"btnbackbtm.png"];
    CGRect frame = CGRectMake(0, 0, 45, 40);
    UIButton* someButton = [[UIButton alloc] initWithFrame:frame];
    [someButton setBackgroundImage:image forState:UIControlStateNormal];
    [someButton setTitle:@" Back" forState:UIControlStateNormal];
    someButton.titleLabel.font = [UIFont fontWithName:@"IowanOldStyle-Bold" size:12];
    [someButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//[UIColor colorWithRed:79.0/255.0 green:38.0/255.0 blue:9.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchDown];
    
    [someButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem* someBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:someButton];
    [self.navigationItem setLeftBarButtonItem:someBarButtonItem];
    
    
    
    
        
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    if(_isphoto){
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else{
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self.parentViewController presentViewController:picker animated:YES completion:NULL];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
 
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)done{
    
    if(_isshare==YES)
        [self.navigationController popToRootViewControllerAnimated:YES];
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Share to Facebook to proceed" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }
    
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
   
    [self imageWithImage:chosenImage scaledToSize:CGSizeMake(612, 612)];
    
    [self merge:chosenImage];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *loc = [defaults objectForKey:@"location"];
    NSLog(@"location %@",loc);
    
    UILabel  *xlabel = [[UILabel alloc] init];//initWithFrame:CGRectMake(_resultImg.frame.size.width/2-50, 5, 100, 35)];
    xlabel.font = [UIFont fontWithName:@"IowanOldStyle-Bold" size:40.0];
    xlabel.textColor = [UIColor colorWithRed:79.0/255.0 green:38.0/255.0 blue:9.0/255.0 alpha:1.0];
    
    xlabel.numberOfLines = 4;
    xlabel.adjustsFontSizeToFitWidth = YES;
    xlabel.textAlignment = NSTextAlignmentCenter;
    //xlabel.text = [NSString stringWithFormat:@"I have completed the challenge at %@",loc];
    xlabel.text = [NSString stringWithFormat:@"%@,\nChallenge completed",loc];
    
    

   
    
    
    CGSize size = CGSizeMake(612, 612);
    UIGraphicsBeginImageContext(size);
    
    [_resultImg.image drawAtPoint:CGPointMake(0,0)];
    [self imageWithImage:_resultImg.image scaledToSize:CGSizeMake(612, 612)];
    
    
    [xlabel drawTextInRect:CGRectMake(size.width/2-100, 20, 200, 90)];
     [xlabel.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
   
    UIGraphicsEndImageContext();
    _resultImg.image = img;
    
    [picker dismissViewControllerAnimated:YES completion:nil];

    
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}



-(void)merge:(UIImage*)img
{
    
    
    
    CGSize size = CGSizeMake(612, 612);
    UIGraphicsBeginImageContext(size);
    
    
    CGPoint thumbPoint = CGPointMake(0,0);
    UIImage *imageA = [self imageWithImage:img scaledToSize:CGSizeMake(612, 612)];
    [imageA drawAtPoint:thumbPoint];
    
     UIImage *starred =[UIImage imageNamed:@"selfie.png"];
    starred = [self imageWithImage:starred scaledToSize:CGSizeMake(612, 612)];

    
    CGPoint starredPoint = CGPointMake(0, 0);
    [starred drawAtPoint:starredPoint];
    
    
    
    
    
    
    UIImage *imageC = UIGraphicsGetImageFromCurrentImageContext();
   
    UIGraphicsEndImageContext();
    
    _resultImg.image = imageC;
    
    

    
    }


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)share:(id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *loc = [defaults objectForKey:@"location"];
    
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])     {
        mySLComposerSheet = [[SLComposeViewController alloc] init];
        mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        NSString *str = [NSString stringWithFormat:@"I have completed the quest at %@. #xploreseum",loc];
        [mySLComposerSheet setInitialText:str];
        [mySLComposerSheet addImage:_resultImg.image];
        [self presentViewController:mySLComposerSheet animated:YES completion:nil];
    }
    

    [mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
        NSString *output;
        
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                output = @"Action Cancelled";
                
                
                break;
            case SLComposeViewControllerResultDone:
                output = @"Post Successfull";
                break;
            default:
                break;
        } //check if everything worked properly. Give out a message on the state.
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook" message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }];
    UIImageWriteToSavedPhotosAlbum(_resultImg.image, nil, nil, nil);
    _isshare=YES;
}










@end
