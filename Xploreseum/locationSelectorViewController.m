//
//  locationSelectorViewController.m
//  Xploreseum
//
//  Created by taufiq on 5/12/14.
//  Copyright (c) 2014 SerembanMaya. All rights reserved.
//

#import "locationSelectorViewController.h"
#import "DataTable.h"
#import "DBController.h"

#import "MultipleChoiceViewController.h"
#import "ImageBlanksViewController.h"
#import "BlanksViewController.h"
#import "CompleteViewController.h"



#import "AppDelegate.h"

@interface locationSelectorViewController ()

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation locationSelectorViewController

@synthesize locationManager,items;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}- (void)awakeFromNib
{
    //set up data
    //your carousel should always be driven by an array of
    //data of some kind - don't store data in your item views
    //or the recycling mechanism will destroy your data once
    //your item views move off-screen
    self.items = [NSMutableArray array];
    for (int i = 0; i < 2; i++)
    {
        [items addObject:@(i)];
    }
    self.db = [DBController sharedDatabaseController:@"xploreseumDB.sqlite"];
    
    _table = [_db ExecuteQuery:@"SELECT * from location_tbl where status='yes'"];
    NSLog(@"database %@",_table.rows);

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    _isNear=NO;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    
    UIImage* image = [UIImage imageNamed:@"btnbackbtm.png"];
    CGRect frame = CGRectMake(0, 0, 45, 40);
    UIButton* someButton = [[UIButton alloc] initWithFrame:frame];
    [someButton setBackgroundImage:image forState:UIControlStateNormal];
    [someButton setTitle:@" Back" forState:UIControlStateNormal];
    someButton.titleLabel.font = [UIFont fontWithName:@"IowanOldStyle-Bold" size:12];
    [someButton setTitleColor:[UIColor colorWithRed:79.0/255.0 green:38.0/255.0 blue:9.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(btnPressed) forControlEvents:UIControlEventTouchDown];
    
    [someButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem* someBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:someButton];
    [self.navigationItem setLeftBarButtonItem:someBarButtonItem];
    
    
    
    UIImage* imager = [UIImage imageNamed:@"btnotherbtm.png"];
    CGRect framer = CGRectMake(0, 0, 45, 40);
    someButtonr = [[UIButton alloc] initWithFrame:framer];
    [someButtonr setBackgroundImage:imager forState:UIControlStateNormal];
    [someButtonr setTitle:@"Near" forState:UIControlStateNormal];
    someButtonr.titleLabel.font = [UIFont fontWithName:@"IowanOldStyle-Bold" size:12];
    [someButtonr setTitleColor:[UIColor colorWithRed:79.0/255.0 green:38.0/255.0 blue:9.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [someButtonr addTarget:self action:@selector(rightButton) forControlEvents:UIControlEventTouchDown];
    
    [someButtonr setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem* someBarButtonItemr = [[UIBarButtonItem alloc] initWithCustomView:someButtonr];
    [self.navigationItem setRightBarButtonItem:someBarButtonItemr];
    
    
    //self.navigationItem.title = @"Xploreseum";
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg640x1008.png"]];
    [backgroundView setFrame:CGRectMake(0, 0, 320, 568)];
    [self.view insertSubview:backgroundView atIndex:0];
    
    _carousel.type = iCarouselTypeCoverFlow2;
    _carousel.bounceDistance = 0.2;
    //_lblName.minimumScaleFactor = 5./_lblName.font.pointSize;
    _lblName.adjustsFontSizeToFitWidth = YES;
       
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLLocationAccuracyHundredMeters;
    [locationManager startUpdatingLocation];
    
    geocoder = [[CLGeocoder alloc] init];
    
    
    
    
    // Do any additional setup after loading the view.
}
-(void)rightButton{
    
    if([someButtonr.titleLabel.text isEqualToString:@"Near"]){
        [someButtonr setTitle:@"List" forState:UIControlStateNormal];
        _isNear=NO;
        [_carousel reloadData];
    }
    else{
        [someButtonr setTitle:@"Near" forState:UIControlStateNormal];
        _isNear=YES;
        [_carousel reloadData];
    }
    
    
}


- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    NSInteger num;
    if(_isNear==YES){
        num = dict.count;
    }
    else if(_isNear==NO){
        num = [_table.rows count];
    }
    return  num;
}

-(void)btnPressed{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}




- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    NSArray *row;
    
    if (_isNear==YES) {
        
    }else if (_isNear==NO){
        row = [_table.rows objectAtIndex:index];
    }
    if (!view)
    {
    	//load new item view instance from nib
        //control events are bound to view controller in nib file
        //note that it is only safe to use the reusingView if we return the same nib for each
        //item view, if different items have different contents, ignore the reusingView value
    	view = [[[NSBundle mainBundle] loadNibNamed:@"loadview" owner:self options:nil] lastObject];
        _lblName.text = [row objectAtIndex:1];
        [_imageMuseum setImage:[UIImage imageNamed:[row objectAtIndex:5]]];
        [_outletEnter addTarget:self action:@selector(btnEnter:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
        
        
        
    }

    
    return view;
}


- (IBAction)btnEnter:(id)sender {
   // AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSLog(@"enter");
    
    NSInteger num = [_carousel indexOfItemViewOrSubview:sender];
    
    NSLog(@"%li",(long)num);
    NSArray *row = [_table.rows objectAtIndex:num];
    
    CLLocationDegrees latitude = [[row objectAtIndex:3]floatValue];//3.090742;
    CLLocationDegrees longitude = [[row objectAtIndex:4]floatValue];//101.603200;
    
    
    [[NSUserDefaults standardUserDefaults] setObject:[row objectAtIndex:1] forKey:@"location"];
    
    NSLog(@"locatiomn %@",[row objectAtIndex:1]);
    
    CLLocation *coord = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    
    NSLog(@"location coord %@",coord);
    
    if ([self getlocationNear:locationManager.location fromRegion:coord]) {
        NSLog(@"in location");
        //_outletEnter.enabled = YES;
        _locationstatusLbl.text = @"in location";
        [self start];
        
    }
    else{
        NSLog(@"not in location");
        //_outletEnter.enabled = NO;
        _locationstatusLbl.text = @"Not in location";
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Not in location" message:@"You are not in location, access denied" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        [self start];
        
    }
    
    
}



-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [locationManager stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    NSLog(@"didUpdateToLocation: %@", locations);
    CLLocation *currentLocation = locations.lastObject;
    
    if (currentLocation != nil) {
        NSLog(@"long %@ lat %@",[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude],[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude]);
           }
    
    
    NSString *idNum;
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for(NSArray *row in _table.rows)
    {
        
    
        NSLog(@"%@",[row objectAtIndex:2]);
        CLLocationDegrees latitude = [[row objectAtIndex:3]floatValue];
        CLLocationDegrees longitude = [[row objectAtIndex:4]floatValue];
        CLLocation *coord = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
        if ([self getlocationNear:locationManager.location fromRegion:coord]) {
            idNum = [row objectAtIndex:0];
            NSLog(@"in here");
            [arr addObject:idNum];        }
        
        
    }
    
    NSLog(@"dict %lu",(unsigned long)arr.count);
   
     //[locationManager stopUpdatingLocation];
    
    //[self theRegion];
    
    
    //rumah
    //CLLocationDegrees latitude = 3.090742;
    //CLLocationDegrees longitude = 101.603200;
    
    /*
   
    CLLocation *coord = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    
    if ([self getlocationNear:currentLocation fromRegion:coord]) {
        NSLog(@"in location");
        _outletEnter.enabled = YES;
        _locationstatusLbl.text = @"in location";
        
    }
    else{
        _outletEnter.enabled = NO;
        _locationstatusLbl.text = @"Not in location";
    }
        
*/
    
    NSLog(@"Resolving the Address");
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            NSLog(@"address %@",[NSString stringWithFormat:@" %@ %@ %@ %@",
                                  placemark.thoroughfare,
                                  placemark.locality,
                                 placemark.administrativeArea,
                                 placemark.country]);
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
    
    

}

-(BOOL)getlocationNear:(CLLocation *)_currentLocation fromRegion:(CLLocation *)_inRegion{
    
    CLLocationDistance distance = [_currentLocation distanceFromLocation:_inRegion];
    NSLog(@"distance %f",distance);
    if(distance<300){
        return YES;
    }
    else
        return NO;
}

-(void)theRegion{
    
    
    
    
    //coordinate rumah
    CLLocationDegrees latitude = 3.090742;
    CLLocationDegrees longitude = 101.603200;
    
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(latitude, longitude);
    CLCircularRegion *region = [[CLCircularRegion alloc]initWithCenter:coord radius:200.0 identifier:[NSString stringWithFormat:@"%f %f",latitude,longitude]];
    
    [locationManager startMonitoringForRegion:region];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region  {
	NSString *event = [NSString stringWithFormat:@"didEnterRegion %@ at %@", region.identifier, [NSDate date]];
	[UIApplication sharedApplication].applicationIconBadgeNumber++;
    _outletEnter.enabled = NO;
	[self updateWithEvent:event];
}


- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
	NSString *event = [NSString stringWithFormat:@"didExitRegion %@ at %@", region.identifier, [NSDate date]];
	_outletEnter.enabled = YES;

	[self updateWithEvent:event];
}


- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error {
	NSString *event = [NSString stringWithFormat:@"monitoringDidFailForRegion %@: %@", region.identifier, error];
	
    _outletEnter.enabled = NO;
	[self updateWithEvent:event];
}

- (void)updateWithEvent:(NSString *)event {
	// Add region event to the updates array.
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"region test" message:event delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
    NSLog(@"event: %@",event);
    
    _locationstatusLbl.text = [NSString stringWithFormat:@"%@",event];
    
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

-(void)start{
    //UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //CompleteViewController *complete = [storyboard instantiateViewControllerWithIdentifier:@"complete"];
    //[self.navigationController pushViewController:complete animated:YES];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.currentQuestionIndex = [NSNumber numberWithInt:1];
        
    self.db = [DBController sharedDatabaseController:@"xploreseumDB.sqlite"];
    
    
    NSString *str = [NSString stringWithFormat:@"SELECT * from question_tbl where id = '%@'",appDelegate.currentQuestionIndex];
    
    _table = [_db ExecuteQuery:str];
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    
    
    for(NSArray* row in _table.rows)
    {
        if ([[row objectAtIndex:3]isEqualToString:@"mcq"]) {
            
            MultipleChoiceViewController *mcq = [storyboard instantiateViewControllerWithIdentifier:@"mcq"];
            [self.navigationController pushViewController:mcq animated:YES];

            
        }
        else if ([[row objectAtIndex:3]isEqualToString:@"blanks"]){
            BlanksViewController *blanks = [storyboard instantiateViewControllerWithIdentifier:@"blanks"];
            [self.navigationController pushViewController:blanks animated:YES];
            
        }
        else if ([[row objectAtIndex:3]isEqualToString:@"image_blanks"]){
            
            ImageBlanksViewController *imgblank = [storyboard instantiateViewControllerWithIdentifier:@"imgBlank"];
            [self.navigationController pushViewController:imgblank animated:YES];
            
        }
 
    }
  
}

@end
