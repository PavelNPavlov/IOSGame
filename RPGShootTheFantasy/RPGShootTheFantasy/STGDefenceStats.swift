//
//  STGDefenceStats.swift
//  RPGShootTheFantasy
//
//  Created by Pavel Pavlov on 2/3/16.
//  Copyright © 2016 Pavel Pavlov. All rights reserved.
//

import UIKit

class STGDefenceStats: NSObject {
    
    var cutDefence: Double;
    var bluntDefence: Double;
    var shotDefence: Double;
    var magicDefence: Double;
    var explosiveDefence: Double;

    override init(){
        self.cutDefence = 0.0;
        self.bluntDefence = 0.0;
        self.shotDefence = 0.0;
        self.magicDefence = 0.0;
        self.explosiveDefence = 0.0;

    }
    
    init(withCut cut: Double, andBlunt blunt: Double, andShot shot: Double, andMagic magic: Double, andExplosive explosive: Double ){
        self.cutDefence = cut;
        self.bluntDefence = blunt;
        self.shotDefence = shot;
        self.magicDefence = magic;
        self.explosiveDefence = explosive;
    }
    
    func addArmour(addCut cut: Double, addBlunt blunt: Double, addShot shot: Double, addMagic magic: Double, addExplosive explosive: Double){
        self.cutDefence = self.cutDefence + cut;
        self.bluntDefence = self.bluntDefence + blunt;
        self.shotDefence = self.shotDefence + shot;
        self.magicDefence = self.magicDefence + magic;
        self.explosiveDefence = self.explosiveDefence + explosive;
        
    }

}
