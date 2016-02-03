//
//  STFGameCharacter.swift
//  RPGShootTheFantasy
//
//  Created by Pavel Pavlov on 2/3/16.
//  Copyright © 2016 Pavel Pavlov. All rights reserved.
//

import UIKit

class STFGameCharacter: NSObject {
    
    var health: Double;
    var defStats: STGDefenceStats;
    var attStats: STGAttackStats;
    
    override init(){
        self.health = 100;
        self.defStats = STGDefenceStats();
        self.attStats = STGAttackStats();
    }

}
