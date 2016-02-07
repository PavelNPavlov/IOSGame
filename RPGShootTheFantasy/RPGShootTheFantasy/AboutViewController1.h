//
//  AboutViewController1.h
//  RPGShootTheFantasy
//
//  Created by Pavel Pavlov on 2/8/16.
//  Copyright © 2016 Pavel Pavlov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AboutViewController1 : UIViewController <CLLocationManagerDelegate>

{
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
}
@end
