//
//  STFItemFactory.swift
//  RPGShootTheFantasy
//
//  Created by Pavel Pavlov on 2/7/16.
//  Copyright © 2016 Pavel Pavlov. All rights reserved.
//

import UIKit

class STFItemFactory: NSObject {

    func makeWeapon(name: String) -> STFItem{
        
        var attValue: STGAttackStats = STGAttackStats();
        switch name{
            case "pistol":
                attValue = STGAttackStats(withCut: 20, andBlunt: 20, andShot: 40, andMagic: 0, andExplosive: 0);
                break;
            case "assaultRifle":
                attValue = STGAttackStats(withCut: 10, andBlunt: 30, andShot: 80, andMagic: 0, andExplosive: 10);
                break;
            case "rifle":
                attValue = STGAttackStats(withCut: 20, andBlunt: 20, andShot: 40, andMagic: 30, andExplosive: 20);
                break;
            case "shotgun":
                attValue = STGAttackStats(withCut: 40, andBlunt: 30, andShot: 80, andMagic: 30, andExplosive: 60);
                break;
            default:
                break;
        }
        
        return STFItem(withAttValue: attValue, andDeffValue: STGDefenceStats());
    }
    
    func makeArmor(name: String) -> STFItem{
        
        var defValue: STGDefenceStats = STGDefenceStats();
        switch name{
            case "light":
                defValue = STGDefenceStats(withCut: 20, andBlunt: 20, andShot: 20, andMagic: 50, andExplosive: 50);
                break;
            case "medium":
                defValue = STGDefenceStats(withCut: 30, andBlunt: 30, andShot: 40, andMagic: 40, andExplosive: 30);
                break;
            case "heavy":
                defValue = STGDefenceStats(withCut: 50, andBlunt: 50, andShot: 50, andMagic: 30, andExplosive: 20);
                break;
            default:
                break;
        }
        
        return STFItem(withAttValue: STGAttackStats(), andDeffValue: defValue);
    }
}
