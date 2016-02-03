//
//  STGAttackStats.swift
//  RPGShootTheFantasy
//
//  Created by Pavel Pavlov on 2/3/16.
//  Copyright © 2016 Pavel Pavlov. All rights reserved.
//

import UIKit

class STGAttackStats: NSObject {
    
    var cutAttack: Double;
    var bluntAttack: Double;
    var shotAttack: Double;
    var magicAttack: Double;
    var explosiveAttack: Double;
    
    override init(){
        self.cutAttack = 0.0;
        self.bluntAttack = 0.0;
        self.shotAttack = 0.0;
        self.magicAttack = 0.0;
        self.explosiveAttack = 0.0;
    }
    
    init(withCut cut: Double, andBlunt blunt: Double, andShot shot: Double, andMagic magic: Double, andExplosive explosive: Double ){
        self.cutAttack = cut;
        self.bluntAttack = blunt;
        self.shotAttack = shot;
        self.magicAttack = magic;
        self.explosiveAttack = explosive;
    }
    
    func addWeapon(addCut cut: Double, addBlunt blunt: Double, addShot shot: Double, addMagic magic: Double, addExplosive explosive: Double){
        self.cutAttack = self.cutAttack + cut;
        self.bluntAttack = self.bluntAttack + blunt;
        self.shotAttack = self.shotAttack + shot;
        self.magicAttack = self.magicAttack + magic;
        self.explosiveAttack = self.explosiveAttack + explosive;
        
    }

}
