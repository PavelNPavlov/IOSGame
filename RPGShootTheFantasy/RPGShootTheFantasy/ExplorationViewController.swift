//
//  ExplorationViewController.swift
//  RPGShootTheFantasy
//
//  Created by Pavel Pavlov on 2/6/16.
//  Copyright © 2016 Pavel Pavlov. All rights reserved.
//

import UIKit

class ExplorationViewController: UIViewController {

    @IBOutlet weak var optionOneBtn: UIButton!
    @IBOutlet weak var optionTwoBtn: UIButton!
    @IBOutlet weak var optionThreeBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        //placeHolderOptions
        self.setOptions();     

        // Do any additional setup after loading the view.
    }
    
    func setOptions(){
        let optionNames = ["forest","dungeon","sewer"]
        
        self.optionOneBtn.setBackgroundImage(UIImage(named: optionNames[0]), forState: .Normal);
        self.optionTwoBtn.setBackgroundImage(UIImage(named: optionNames[1]), forState: .Normal);
        self.optionThreeBtn.setBackgroundImage(UIImage(named: optionNames[2]), forState: .Normal);
        
        self.optionOneBtn.setTitle(optionNames[0], forState: .Normal);
        self.optionTwoBtn.setTitle(optionNames[1], forState: .Normal);
        self.optionThreeBtn.setTitle(optionNames[2], forState: .Normal);
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
