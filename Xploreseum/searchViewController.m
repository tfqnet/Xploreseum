//
//  searchViewController.m
//  Xploreseum
//
//  Created by taufiq on 6/10/14.
//  Copyright (c) 2014 SerembanMaya. All rights reserved.
//

#import "searchViewController.h"
#import "DataTable.h"
#import "DBController.h"

@interface searchViewController ()

@end

@implementation searchViewController

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
    
    //[[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    
    self.db = [DBController sharedDatabaseController:@"xploreseumDB.sqlite"];
    
    _table = [_db ExecuteQuery:@"SELECT * from location_tbl where status='yes'"];
    NSLog(@"database %@",_table.rows);
    stringArray = [[NSMutableArray alloc] init];
    for(NSArray *row in _table.rows){
        [stringArray addObject:[row objectAtIndex:1]];
    }
    NSLog(@"data %@",stringArray);
    
    filteredContentList = [[NSMutableArray alloc] init];
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    if (isSearching) {
        return [filteredContentList count];
    }
    else {

        return [_table.rows count];
    }
   
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSArray *row;
    
    
    if (isSearching) {
        NSLog(@"%@",[filteredContentList objectAtIndex:indexPath.row]);
    }
    else {
        row = [_table.rows objectAtIndex:indexPath.row];
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    cell.textLabel.text =[row objectAtIndex:1];
    
    return cell;
}



- (void)searchTableList {
    NSString *searchString = _searchBar.text;
    NSLog(@"searh %@",searchString);
    
    for (NSArray *row in _table.rows) {
        //NSLog(@"temptstr %@",tempStr);
        
        if([searchString isEqualToString:@"M"]){
            NSLog(@"yes");
        }
        if([searchString rangeOfString:[row objectAtIndex:1]].location == NSNotFound){
            NSLog(@"No %@",[row objectAtIndex:1]);
        }
        else
        {
            NSLog(@"yes %@",[row objectAtIndex:1]);
        }
        NSComparisonResult result = [[row objectAtIndex:1] compare:searchString options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchString length])];
        if (result == NSOrderedSame) {
            NSLog(@"result %ld",result);
            [filteredContentList addObject:[row objectAtIndex:1]];
        }
    }
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    isSearching = YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"Text change - %d",isSearching);
    
    //Remove all objects first.
    [filteredContentList removeAllObjects];
    
    if([searchText length] != 0) {
        isSearching = YES;
        [self searchTableList];
    }
    else {
        isSearching = NO;
    }
    [_searchTableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Cancel clicked");
    [_searchTableView reloadData];

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Search Clicked");
    [self searchTableList];
}


-(void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        CGRect statusBarFrame =  [[UIApplication sharedApplication] statusBarFrame];
        [UIView animateWithDuration:0.25 animations:^{
            for (UIView *subview in self.view.subviews)
                subview.transform = CGAffineTransformMakeTranslation(0, statusBarFrame.size.height);
        }];
    }
}

-(void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        [UIView animateWithDuration:0.25 animations:^{
            for (UIView *subview in self.view.subviews)
                subview.transform = CGAffineTransformIdentity;
        }];
    }
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
