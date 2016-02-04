//
//  MenuViewController.swift
//  RPGShootTheFantasy
//
//  Created by Pavel Pavlov on 2/3/16.
//  Copyright © 2016 Pavel Pavlov. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var option1: UIImageView!
    @IBOutlet weak var option2: UIImageView!
    @IBOutlet weak var option3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        option1.image = UIImage(named: "forest");
        option2.image = UIImage(named: "forest");
        option3.image = UIImage(named: "forest");



        // Do any additional setup after loading the view.
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
