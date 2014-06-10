//
//  ListViewController.m
//  Xploreseum
//
//  Created by taufiq on 6/9/14.
//  Copyright (c) 2014 SerembanMaya. All rights reserved.
//

#import "ListViewController.h"
#import "listCell.h"
#import "DataTable.h"
#import "DBController.h"

@interface ListViewController ()

@end

@implementation ListViewController

@synthesize listCollectionView;

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
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];

    
    [listCollectionView registerNib:[UINib nibWithNibName:@"listCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:listCollectionView];
    
    self.db = [DBController sharedDatabaseController:@"xploreseumDB.sqlite"];
    
    _table = [_db ExecuteQuery:@"SELECT * from location_tbl where status='yes'"];
    NSLog(@"database %@",_table.rows);

    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  _table.rows.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    NSArray *row = [_table.rows objectAtIndex:indexPath.row];
    listCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
 
    [cell.imgView setImage:[UIImage imageNamed:[row objectAtIndex:5]]];
    
    
    return cell;
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
