//
//  GameScene.swift
//  RPGShootTheFantasy
//
//  Created by Pavel Pavlov on 2/3/16.
//  Copyright (c) 2016 Pavel Pavlov. All rights reserved.
//

import SpriteKit

class FightScene: SKScene {
    
    // Constants
    
    let wizard = "wizard";
    let ork = "ork";
    let skeleton = "skeleton";
    
    let skeletonFrameCount = [8,4,3];
    
    var object : SKSpriteNode!;
    var location: String!;
    var atlasName: String!;
    var idleAnimationFrames: [SKTexture]!;
    var attackAnimationFrames: [SKTexture]!;
    var takeDmgAnimationFrames: [SKTexture]!;
    var animSeparation: [Int]!;
    var enemies: [SKSpriteNode] = [];
    var eHealth: [SKLabelNode] = [];
    var enemyLocations: [CGPoint]!;
    var attackIndicator: SKSpriteNode!;
    var gestureArea: SKSpriteNode!;
    var indicatedIndex: Int = 0;
    
    override func didMoveToView(view: SKView) {
        
        view.backgroundColor = UIColor.whiteColor();
        // Get EnemyType
        
        switch location{
        case "forest":
            self.atlasName = ork;
          
            break;
        case "dungeon":
            self.atlasName = wizard;
            break;
        case "sewer":
            self.atlasName = skeleton
            animSeparation = skeletonFrameCount;
            break;
        default:
            print("Something went wrong with enemy type selection");
            break;
        }
        
        let animateAtlas = SKTextureAtlas(named: self.atlasName);
        
        //init temp
        
        var attack = [SKTexture]();
        var idle = [SKTexture]();
        var hurt = [SKTexture]();
        
        //attack
        
        for var i=1; i<=self.animSeparation[0]; i++ {
            let textureName = "idle"+String(i);
            idle.append(animateAtlas.textureNamed(textureName))
        }
        
        //takeDmg
        
        for var i=1; i<=self.animSeparation[1]; i++ {
            let textureName = "attack"+String(i);
            attack.append(animateAtlas.textureNamed(textureName))
        }
        
        //idle
        
        for var i=1; i<=self.animSeparation[2]; i++ {
            let textureName = "hurt"+String(i);
            hurt.append(animateAtlas.textureNamed(textureName))
        }
        
        //setValues
        
        self.attackAnimationFrames = attack;
        self.idleAnimationFrames = idle;
        self.takeDmgAnimationFrames = hurt;
        
        self.attackIndicator = SKSpriteNode(imageNamed: "arrow");
        attackIndicator.xScale = 0.5;
        attackIndicator.yScale = 0.5;
        addChild(attackIndicator);
        
        self.makeEnemies(0);
        
        let gestureRecognizerSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipe:"))
       
        self.view!.addGestureRecognizer(gestureRecognizerSwipe)
         gestureRecognizerSwipe.direction = [.Left,.Right];
        
        
        let gestureRecognizerPinch = UIPinchGestureRecognizer(target: self, action: Selector("handlePinch:"))
        self.view!.addGestureRecognizer(gestureRecognizerPinch)
        
        
        
        gestureArea = SKSpriteNode(imageNamed: "gesture");
        gestureArea.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame)-200);
        gestureArea.name = "command";
        
        
        addChild(gestureArea);
    }
    
    func handlePinch(recognizer: UIPinchGestureRecognizer) {
        
        if(recognizer.state != .Ended){
            return;
        }
        
        print("Pinch");
        var touchLocation = recognizer.locationInView(recognizer.view)
        touchLocation = self.convertPointFromView(touchLocation)
        let node = self.nodeAtPoint(touchLocation);
        
        if(node.name == "command"){
            print("pinch");
        }
    }
    
    func handleSwipe(recognizer: UISwipeGestureRecognizer) {
        if(recognizer.state != .Ended){
            return;
        }
        
        var touchLocation = recognizer.locationInView(recognizer.view)
        touchLocation = self.convertPointFromView(touchLocation)
        let node = self.nodeAtPoint(touchLocation);

        if(node.name == "command"){
            print("swipe");
        }
    }
    
    func makeEnemies(count: Int){
        
        let firstFrame = self.idleAnimationFrames[0];
        

        
        let enemy1 = SKSpriteNode(texture: firstFrame);
        enemy1.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame)+100);
        enemy1.name = "e1";

        
        
        let enemy2 = SKSpriteNode(texture: firstFrame);
        enemy2.position = CGPoint(x: CGRectGetMidX(self.frame)+100, y: CGRectGetMidY(self.frame));
        enemy2.name = "e2";
//        
        let enemy3 = SKSpriteNode(texture: firstFrame);
        enemy3.position = CGPoint(x: CGRectGetMidX(self.frame)-100, y: CGRectGetMidY(self.frame));
        enemy3.name = "e3";
        
        
        let eHealth1 = SKLabelNode(text: "100");
        eHealth1.position = enemy1.position;
        eHealth1.position.y = eHealth1.position.y-100;
        let eHealth2 = SKLabelNode(text: "100");
        eHealth2.position = enemy2.position;
        eHealth2.position.y = eHealth2.position.y-100;
        let eHealth3 = SKLabelNode(text: "100");
        eHealth3.position = enemy3.position;
        eHealth3.position.y = eHealth3.position.y-100;
        
        self.addAnimationToObj(enemy1);
        self.addAnimationToObj(enemy2);
        self.addAnimationToObj(enemy3);

        self.enemies.append(enemy1);
        self.enemies.append(enemy2);
        self.enemies.append(enemy3);
        self.eHealth.append(eHealth1);
        self.eHealth.append(eHealth2);
        self.eHealth.append(eHealth3);
        
        addChild(enemy1)
        addChild(enemy2)
        addChild(enemy3)
        addChild(eHealth1)
        addChild(eHealth2)
        addChild(eHealth3)
      
    }
    
    func addAnimationToObj(node: SKSpriteNode){
        node.runAction(SKAction.repeatActionForever(
            SKAction.animateWithTextures(self.idleAnimationFrames,
                timePerFrame: 0.2,
                resize: false,
                restore: true)),
            withKey:"animationMain")
        
    }
    
    //startAnimation
    
    func animateAttack() {
        object.runAction(SKAction.animateWithTextures(self.attackAnimationFrames,
                timePerFrame: 0.2,
                resize: false,
                restore: true));
    }
    
    func animateDmg() {
        object.runAction(SKAction.animateWithTextures(self.idleAnimationFrames,
            timePerFrame: 0.2,
            resize: false,
            restore: true));
    }
    
    
    func animateIdle() {
        object.runAction(SKAction.repeatActionForever(
            SKAction.animateWithTextures(self.idleAnimationFrames,
                timePerFrame: 0.2,
                resize: false,
                restore: true)),
            withKey:"animationMain")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let touch:UITouch = touches.first! as UITouch
        let positionInScene = touch.locationInNode(self)
        let touchedNode = self.nodeAtPoint(positionInScene)
        
        let name = touchedNode.name;
        
        if(name == "e1"){
            indicatedIndex = 0;
        }
        else if(name == "e2"){
            indicatedIndex = 1;
        }
        else if(name == "e3"){
            indicatedIndex = 2;
        }
        else{
            return;
        }
        
        attackIndicator.position = enemies[indicatedIndex].position;
        
        attackIndicator.position.y = attackIndicator.position.y + 50;
        
        var healt = Int(eHealth[indicatedIndex].text!)!;
        healt = healt - 10;
        
        eHealth[indicatedIndex].text = String(healt);

    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
