//
//  GameViewController.swift
//  RPGShootTheFantasy
//
//  Created by Pavel Pavlov on 2/3/16.
//  Copyright (c) 2016 Pavel Pavlov. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    var fightLocation: String!;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let scene = FightScene(size: view.bounds.size)
        scene.location = self.fightLocation;
        
        let skView = view as! SKView
        scene.scaleMode = .ResizeFill
        skView.presentScene(scene)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
