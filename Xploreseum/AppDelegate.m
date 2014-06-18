//
//  AppDelegate.m
//  Xploreseum
//
//  Created by taufiq on 5/12/14.
//  Copyright (c) 2014 SerembanMaya. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "DataTable.h"
#import "DBController.h"

#import "locationSelectorViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@implementation AppDelegate

@synthesize viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [FBLoginView class];
    [Parse setApplicationId:@"zLITzn6rtiRX7JdchxgqlNJ2Air0tPznuFgEMyOr"
                  clientKey:@"QOMibc6cb1Vvg63MNf0vqGKQqOhv5KGAplRQhH0P"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    [PFFacebookUtils initializeFacebook];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 1);
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:115.0/255.0 green:53.0/255.0 blue:17.0/255.0 alpha:1.0]];
    
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:79.0/255.0 green:38.0/255.0 blue:9.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont fontWithName:@"IowanOldStyle-Bold" size:18.0], NSFontAttributeName, nil]];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
    
    self.db = [DBController sharedDatabaseController:@"xploreseumDB.sqlite"];
    
    _table = [_db ExecuteQuery:@"SELECT * from location_tbl where status='yes'"];
     NSLog(@"database %@",_table.rows);

    
    
    [NSThread sleepForTimeInterval:1.0];


    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
	
	if ([CLLocationManager significantLocationChangeMonitoringAvailable]) {
		// Stop normal location updates and start significant location change updates for battery efficiency.
		[viewController.locationManager stopUpdatingLocation];
		[viewController.locationManager startMonitoringSignificantLocationChanges];
	}
	else {
		NSLog(@"Significant location change monitoring is not available.");
	}

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];
    if ([CLLocationManager significantLocationChangeMonitoringAvailable]) {
		// Stop significant location updates and start normal location updates again since the app is in the forefront.
		[viewController.locationManager stopMonitoringSignificantLocationChanges];
		[viewController.locationManager startUpdatingLocation];
	}
	else {
		NSLog(@"Significant location change monitoring is not available.");
	}
	
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
	

}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                        withSession:[PFFacebookUtils session]];
}




-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    NSLog(@"didUpdateToLocation: %@", locations);
    CLLocation *currentLocation = locations.lastObject;
    
    
    
    [locationManager stopUpdatingLocation];
    
    if (currentLocation != nil) {
        NSLog(@"long %@ lat %@",[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude],[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude]);
        
        for(NSArray *row in _table.rows)
        {
            
            
            NSLog(@"%@",[row objectAtIndex:2]);
            CLLocationDegrees latitude = [[row objectAtIndex:3]floatValue];
            CLLocationDegrees longitude = [[row objectAtIndex:4]floatValue];
            CLLocation *coord = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
            
            CLLocationDistance distance = [currentLocation distanceFromLocation:coord];
           // NSString *dst = [NSString stringWithFormat:@"%f",distance];
            
            NSString *str = [NSString stringWithFormat:@"UPDATE location_tbl set distance = '%f' where id = %@",distance,[row objectAtIndex:0]];
            
            int i;
            i = [_db ExecuteNonQuery:str];
            
           
            
            
        }

        
        
    }
    
    
    
    
   
    
       
}



@end
