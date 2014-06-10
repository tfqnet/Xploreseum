//
//  locationSelectorViewController.h
//  Xploreseum
//
//  Created by taufiq on 5/12/14.
//  Copyright (c) 2014 SerembanMaya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "iCarousel.h"


@class  DataTable,DBController;
@interface locationSelectorViewController : UIViewController<CLLocationManagerDelegate,iCarouselDataSource,iCarouselDelegate>{
    
    
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    
    UIButton* someButtonr;
    NSMutableArray *dict;
}

@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (nonatomic, strong) IBOutlet iCarousel *carousel;

@property (strong, nonatomic) IBOutlet UIImageView *imageMuseum;

@property (strong, nonatomic) IBOutlet UILabel *locationstatusLbl;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet UIButton *outletEnter;

@property (strong, nonatomic) DBController* db;
@property (strong, nonatomic) DataTable* table;
@property (strong, nonatomic) DataTable* nearTable;

@property (atomic,assign)  BOOL isNear;



- (IBAction)btnEnter:(id)sender;
@end
