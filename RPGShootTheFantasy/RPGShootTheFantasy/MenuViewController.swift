//
//  MenuViewController.swift
//  RPGShootTheFantasy
//
//  Created by Pavel Pavlov on 2/3/16.
//  Copyright © 2016 Pavel Pavlov. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    
    @IBOutlet weak var bgImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bgImage.image = UIImage(named: "menuBg");
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    NSString *storyBoardId = @"detailsScene";
//    
//    DetailsViewController *detailsVC =
//    [self.storyboard instantiateViewControllerWithIdentifier:storyBoardId];
//    detailsVC.phone = phone;
    

    
    @IBAction func play(sender: AnyObject) {
              print("Play");
        let id = "exploreVC";
        
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier(id);
        self.navigationController?.pushViewController(viewController!, animated: true);
  
    }
    @IBAction func about(sender: AnyObject) {
        print("About");
        let id = "aboutVC";
        
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier(id);
        self.navigationController?.pushViewController(viewController!, animated: true);

    }
    @IBAction func restore(sender: AnyObject) {
        print("Restore");
    }


    @IBAction func exit(sender: AnyObject) {
        print("Exit");
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
