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
    
    override init() {       
        
        self.weapon = STFItem();
        self.armour = STFItem();
        
        super.init();
        
        self.attStats = STGAttackStats(withCut: 0, andBlunt: 10, andShot: 0, andMagic: 0, andExplosive: 0);
        self.defStats = STGDefenceStats(withCut: 10, andBlunt: 10, andShot: 10, andMagic: 10, andExplosive: 10);

    }

}
