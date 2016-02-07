//
//  STFGameManager.swift
//  RPGShootTheFantasy
//
//  Created by Pavel Pavlov on 2/3/16.
//  Copyright © 2016 Pavel Pavlov. All rights reserved.
//

import UIKit

class STFGameManager: NSObject {
    
    var forestExplored = 0;
    var dungeonExplore = 0;
    var sewerExplore = 0;
    
    var maxExplore = 20;
    
    var player = STFPlayer();
    var itemFactory = STFItemFactory();

}
