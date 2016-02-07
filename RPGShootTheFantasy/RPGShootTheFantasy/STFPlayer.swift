//
//  STFPlayer.swift
//  RPGShootTheFantasy
//
//  Created by Pavel Pavlov on 2/3/16.
//  Copyright © 2016 Pavel Pavlov. All rights reserved.
//

import UIKit

class STFPlayer: STFGameCharacter {
    
    var weapon: STFItem;
    var armour: STFItem;
    var weapons: [String] = ["pistol"];
    var armors: [String] = ["light"];
    var level: Int;
    
    override init() {       
        
        self.weapon = STFItem();
        self.armour = STFItem();
        
        self.level = 1;
      
        super.init();
        
        self.health = 120;
        self.attStats = STGAttackStats(withCut: 0, andBlunt: 10, andShot: 0, andMagic: 0, andExplosive: 0);
        self.defStats = STGDefenceStats(withCut: 10, andBlunt: 10, andShot: 10, andMagic: 10, andExplosive: 10);

    }
    
    func levelUp(){
        self.level++;
    }
    
    func getAttack() -> STGAttackStats{
        return STGAttackStats (
            withCut: attStats.cutAttack+weapon.attValue.cutAttack,
            andBlunt: attStats.bluntAttack + weapon.attValue.bluntAttack,
            andShot: attStats.shotAttack + weapon.attValue.shotAttack,
            andMagic: attStats.magicAttack + weapon.attValue.shotAttack,
            andExplosive: attStats.explosiveAttack + weapon.attValue.explosiveAttack)
    }
    
    
    func getDefence() -> STGDefenceStats{
        return STGDefenceStats (
            withCut: defStats.cutDefence + armour.defValue.cutDefence,
            andBlunt: defStats.bluntDefence + armour.defValue.bluntDefence,
            andShot: defStats.shotDefence + armour.defValue.shotDefence,
            andMagic: defStats.magicDefence + armour.defValue.magicDefence,
            andExplosive: defStats.explosiveDefence + armour.defValue.explosiveDefence)
    }

}
