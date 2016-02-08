//
//  InventoryViewController.swift
//  RPGShootTheFantasy
//
//  Created by Pavel Pavlov on 2/6/16.
//  Copyright © 2016 Pavel Pavlov. All rights reserved.
//

import UIKit

class InventoryViewController: UIViewController {


    @IBOutlet weak var weapon: UIImageView!
    @IBOutlet weak var armour: UIImageView!
    
    var weapons: [String]!;
    var armors: [String]!;
    
    var currentWeapon = 0;
    var currentArmor = 0;
    override func viewDidLoad() {
        super.viewDidLoad()

        currentWeapon = 0;
        currentArmor = 0;
        self.getItems();
        if(weapons.count>0){
            self.weapon.image = UIImage(named: weapons[currentWeapon]);
        }
        if(armors.count>0){
            self.armour.image = UIImage(named: armors[currentArmor]);
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        currentWeapon = 0;
        currentArmor = 0;
        self.getItems();
        if(weapons.count>0){
            self.weapon.image = UIImage(named: weapons[currentWeapon]);
        }
        if(armors.count>0){
            self.armour.image = UIImage(named: armors[currentArmor]);
        }
    }
    
    func getItems(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let gameManager = appDelegate.gameManager;
        
        if(gameManager.player.level == 10 && gameManager.player.weapons.count<2){
            gameManager.player.weapons.append("assaultRifle")
        }
        
        if(gameManager.player.level == 15 && gameManager.player.armors.count<2){
            gameManager.player.armors.append("medium")
        }
        
        if(gameManager.player.level == 40 && gameManager.player.weapons.count<3){
            gameManager.player.weapons.append("rifle")
        }
        
        if(gameManager.player.level == 50 && gameManager.player.weapons.count<4){
            gameManager.player.weapons.append("shotgun")
            gameManager.player.armors.append("heavy")
        }
        
        weapons = gameManager.player.weapons
        armors = gameManager.player.armors
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextWeapon(sender: AnyObject) {
        
        if(currentWeapon<weapons.count-1){
            currentWeapon++;
            self.weapon.image = UIImage(named: weapons[currentWeapon]);
        }
    }
    @IBAction func prevWeapon(sender: AnyObject) {
        
        if(currentWeapon>0){
            currentWeapon--;
            self.weapon.image = UIImage(named: weapons[currentWeapon]);
        }

    }
    
    @IBAction func nextArmor(sender: AnyObject) {
        if(currentArmor<armors.count - 1){
            currentArmor++;
            self.armour.image = UIImage(named: armors[currentArmor]);
        }
    }

    @IBAction func prevArmor(sender: AnyObject) {
        if(currentArmor>0){
            currentArmor--;
            self.armour.image = UIImage(named: armors[currentArmor]);
        }
    }

    @IBAction func equip(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let player = appDelegate.gameManager.player;
        let itemFactory = appDelegate.gameManager.itemFactory;
        
        let armor = itemFactory.makeArmor(armors[currentArmor]);
        let weapon = itemFactory.makeWeapon(weapons[currentWeapon]);
        
        player.weapon = weapon;
        player.armour = armor;
        
        
        let query = PFQuery(className: "Player");
        
        
        let result = query.whereKey("DeviceID", equalTo: appDelegate.deviceId).getFirstObjectInBackgroundWithBlock({ (obj: PFObject?, err: NSError?) -> Void in
            if((err) == nil){
                obj!["Level"] = player.level;
                obj!["Weapons"] = player.weapons.joinWithSeparator(",")
                obj!["Armors"] = player.armors.joinWithSeparator(",")
                
                obj!.saveInBackground();
            }
            
        });
        
        self.navigationController?.popViewControllerAnimated(true);
        
        
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
