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
    
    let weapons = ["pistol","rifle","assaultRifle","shotgun"];
    let armors = ["light","medium","heavy"];
    
    var currentWeapon = 0;
    var currentArmor = 0;
    override func viewDidLoad() {
        super.viewDidLoad()

        currentWeapon = 0;
        currentArmor = 0;
        self.weapon.image = UIImage(named: weapons[currentWeapon]);
        self.armour.image = UIImage(named: armors[currentArmor]);
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextWeapon(sender: AnyObject) {
        
        if(currentWeapon<3){
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
        if(currentArmor<armors.count){
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
