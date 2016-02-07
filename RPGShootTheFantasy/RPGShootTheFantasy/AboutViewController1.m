//
//  AboutViewController1.m
//  RPGShootTheFantasy
//
//  Created by Pavel Pavlov on 2/8/16.
//  Copyright © 2016 Pavel Pavlov. All rights reserved.
//

#import "AboutViewController1.h"


@interface AboutViewController1 ()
@property (weak, nonatomic) IBOutlet UILabel *text;

@end

@implementation AboutViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    [self CurrentLocationIdentifier];
}

-(void)CurrentLocationIdentifier
{
    //---- For getting current gps location
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager requestWhenInUseAuthorization];
    [locationManager requestAlwaysAuthorization];
    
    [locationManager startUpdatingLocation];    //------
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    currentLocation = [locations objectAtIndex:0];
    [locationManager stopUpdatingLocation];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (!(error))
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
//             NSLog(@"\nCurrent Location Detected\n");
//             NSLog(@"placemark %@",placemark);
             NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
             NSString *Address = [[NSString alloc]initWithString:locatedAt];
             NSString *Area = [[NSString alloc]initWithString:placemark.locality];
             NSString *Country = [[NSString alloc]initWithString:placemark.country];
             NSString *CountryArea = [NSString stringWithFormat:@"%@, %@", Area,Country];
             NSLog(@"%@",CountryArea);
             
             NSMutableString *textData = [[NSMutableString alloc] initWithString:self.text.text];
             NSString *thankYou = [[NSString alloc] initWithFormat:@"\nThank you for playing from: %@",CountryArea];
             [textData appendString:thankYou ];
             self.text.text = textData;
         }
         else
         {
//             NSLog(@"Geocode failed with error %@", error);
//             NSLog(@"\nCurrent Location Not Detected\n");
             return;
             //CountryArea = NULL;
         }
         /*---- For more results
          placemark.region);
          placemark.country);
          placemark.locality);
          placemark.name);
          placemark.ocean);
          placemark.postalCode);
          placemark.subLocality);
          placemark.location);
          ------*/
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
