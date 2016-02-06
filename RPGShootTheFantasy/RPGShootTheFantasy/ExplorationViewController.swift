//
//  ExplorationViewController.swift
//  RPGShootTheFantasy
//
//  Created by Pavel Pavlov on 2/6/16.
//  Copyright © 2016 Pavel Pavlov. All rights reserved.
//

import UIKit
import AVFoundation

class ExplorationViewController: UIViewController {

    @IBOutlet weak var optionOneBtn: UIButton!
    @IBOutlet weak var optionTwoBtn: UIButton!
    @IBOutlet weak var optionThreeBtn: UIButton!
    
    let soundEffectFile = "choice.mp3"
    var audioPlayer: AVAudioPlayer!;

    override func viewDidLoad() {
        super.viewDidLoad()
        //placeHolderOptions
        self.setOptionButtons();
        self.setUpSoundEffects();


        // Do any additional setup after loading the view.
    }
    
    func setUpSoundEffects(){
        let path = NSBundle.mainBundle().resourcePath!+"/" + self.soundEffectFile;
        let url = NSURL(fileURLWithPath: path);
        do{
            audioPlayer = try AVAudioPlayer(contentsOfURL: url);
        }
        catch {
            print(" Sound Error");
        }
        audioPlayer.numberOfLoops = 0;

    }
    
    func setOptionButtons(){
        let optionNames = ["forest","dungeon","sewer"]
        
        // Background Images
        self.optionOneBtn.setBackgroundImage(UIImage(named: optionNames[0]), forState: .Normal);
        self.optionTwoBtn.setBackgroundImage(UIImage(named: optionNames[1]), forState: .Normal);
        self.optionThreeBtn.setBackgroundImage(UIImage(named: optionNames[2]), forState: .Normal);
        
        // Text
        self.optionOneBtn.setTitle(optionNames[0], forState: .Normal);
        self.optionTwoBtn.setTitle(optionNames[1], forState: .Normal);
        self.optionThreeBtn.setTitle(optionNames[2], forState: .Normal);
        
        // Actions
        self.optionOneBtn.addTarget(self, action: "buttonAction:", forControlEvents: .TouchUpInside);
        self.optionTwoBtn.addTarget(self, action: "buttonAction:", forControlEvents: .TouchUpInside);
        self.optionThreeBtn.addTarget(self, action: "buttonAction:", forControlEvents: .TouchUpInside);
    
    }
    
    func buttonAction(sender: UIButton){
        self.audioPlayer.stop();
        let levelName = sender.titleLabel!.text!;
        self.audioPlayer.play();
        
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("fightScene") as! GameViewController;
        viewController.fightLocation = levelName;
        
        self.navigationController?.pushViewController(viewController, animated: true);
        
        print(levelName);
    }

    @IBAction func inventory(sender: AnyObject) {
        let viewController = self.storyboard?.instantiateViewControllerWithIdentifier("inventoryVC");
        self.navigationController?.pushViewController(viewController!, animated: true);
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
