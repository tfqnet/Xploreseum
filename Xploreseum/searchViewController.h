//
//  searchViewController.h
//  Xploreseum
//
//  Created by taufiq on 6/10/14.
//  Copyright (c) 2014 SerembanMaya. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DataTable,DBController;
@interface searchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate, UISearchDisplayDelegate>
{
    
    NSMutableArray *stringArray;
    NSMutableArray *filteredContentList;
    BOOL isSearching;

}

@property (strong, nonatomic) IBOutlet UITableView *searchTableView;
@property (strong, nonatomic) DBController* db;
@property (strong, nonatomic) DataTable* table;

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchDisplay;
@end
