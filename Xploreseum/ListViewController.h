//
//  ListViewController.h
//  Xploreseum
//
//  Created by taufiq on 6/9/14.
//  Copyright (c) 2014 SerembanMaya. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataTable,DBController;
@interface ListViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *listCollectionView;


@property (strong, nonatomic) DBController* db;
@property (strong, nonatomic) DataTable* table;


@end
