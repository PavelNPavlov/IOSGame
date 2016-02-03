//
//  STFItem.swift
//  RPGShootTheFantasy
//
//  Created by Pavel Pavlov on 2/3/16.
//  Copyright © 2016 Pavel Pavlov. All rights reserved.
//

import UIKit

class STFItem: NSObject {

    var attValue: STGAttackStats;
    var defValue: STGDefenceStats;
    
    override init() {
        
        self.attValue = STGAttackStats();
        self.defValue = STGDefenceStats();
    }
    
    init(withAttValue attValue: STGAttackStats, andDeffValue defValue: STGDefenceStats){
        self.attValue = attValue;
        self.defValue = defValue;
    }
}
