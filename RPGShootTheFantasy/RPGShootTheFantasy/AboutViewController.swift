//
//  AboutViewController.swift
//  RPGShootTheFantasy
//
//  Created by Pavel Pavlov on 2/7/16.
//  Copyright © 2016 Pavel Pavlov. All rights reserved.
//

import UIKit
import CoreLocation

class AboutViewController: UIViewController,  CLLocationManagerDelegate {

    var locationManger: CLLocationManager!;
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManger = CLLocationManager();
        locationManger.delegate = self;
        locationManger.desiredAccuracy = kCLLocationAccuracyKilometer;
        locationManger.startUpdatingLocation();
        // Do any additional setup after loading the view.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var location = locations.last;
        print(location);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
