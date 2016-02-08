//
//  AppDelegate.swift
//  RPGShootTheFantasy
//
//  Created by Pavel Pavlov on 2/3/16.
//  Copyright © 2016 Pavel Pavlov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var gameManager = STFGameManager();
    var deviceId: String!;

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        Parse.enableLocalDatastore()
        
        // Initialize Parse.
        Parse.setApplicationId("UcI0ca8lLWkc6JjQqNeRA5klwZu70scsCDKBq6iI",
            clientKey: "p7Sn42EOBjsll8z8ULgAyVt7AQ1RDEOzswzTmSvB")
        
        
        deviceId = UIDevice.currentDevice().identifierForVendor!.UUIDString
        
        let query = PFQuery(className: "Player");
        
            let result = query.whereKey("DeviceID", equalTo: deviceId).getFirstObjectInBackgroundWithBlock({ (obj: PFObject?, err: NSError?) -> Void in
                if((err) != nil){
                    let objN = PFObject(className: "Player");
                    objN["DeviceID"] = self.deviceId;
                    objN["Level"] = 1;
                    objN["Weapons"] = "pistol"
                    objN["Armors"] = "light"
                    
                    objN.saveInBackground();
                }
                else{
                    let player = self.gameManager.player;
                    
                    player.level = ob
                }
            });


      
        
                return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

