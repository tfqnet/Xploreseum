//
//  AppDelegate.h
//  Xploreseum
//
//  Created by taufiq on 5/12/14.
//  Copyright (c) 2014 SerembanMaya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@class locationSelectorViewController,DataTable,DBController;
@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
}

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain) locationSelectorViewController *viewController;

@property (nonatomic, assign) NSNumber *currentQuestionIndex;
@property (nonatomic, assign) NSInteger usermarks;
@property (nonatomic, assign) NSString *locationName;

@property (strong, nonatomic) DBController* db;
@property (strong, nonatomic) DataTable* table;




@end
