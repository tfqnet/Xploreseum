//
//  TestViewController.m
//  Xploreseum
//
//  Created by taufiq on 6/9/14.
//  Copyright (c) 2014 SerembanMaya. All rights reserved.
//

#import "TestViewController.h"
#import <Parse/Parse.h>

#import "DataTable.h"
#import "DBController.h"

@interface TestViewController ()

@end

@implementation TestViewController

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
    
    self.db = [DBController sharedDatabaseController:@"xploreseumDB.sqlite"];
    
    _table = [_db ExecuteQuery:@"SELECT * from location_tbl where status='yes'"];
    NSLog(@"database %@",_table.rows);
    

    
    PFQuery *query = [PFQuery queryWithClassName:@"museum"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %lu scores.", (unsigned long)objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
              //  NSLog(@"%@", object);
                NSString *museumName = object[@"name"];
                NSString *latitude = object[@"latitude"];
                NSString *longitude = object[@"longitude"];
                NSString *state = object[@"state"];
                NSString *status = object[@"status"];
                NSString *imageName = object[@"imageName"];

                
                PFFile *userImageFile = object[@"image"];
                [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
                    if (!error) {
                        UIImage *image = [UIImage imageWithData:imageData];
                     //   NSLog(@"image %@",image);
                        
                        NSData *pngData = UIImagePNGRepresentation(image);
                        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                        NSString *documentsPath = [paths objectAtIndex:0];
                        NSString *imgName = [NSString stringWithFormat:@"%@.png",imageName];//Get the docs directory
                        NSString *filePath = [documentsPath stringByAppendingPathComponent:imgName]; //Add the file name
                        [pngData writeToFile:filePath atomically:YES];
                    }
                }];
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    // Do any additional setup after loading the view.
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

@end
