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
    
    let playerTurn = "Player Turn";
    let enemyTurn = "Enemy Turn";
    
    let skeletonFrameCount = [8,4,3];

    var location: String!;
    var atlasName: String!;
    var idleAnimationFrames: [SKTexture]!;
    var attackAnimationFrames: [SKTexture]!;
    var takeDmgAnimationFrames: [SKTexture]!;
    var animSeparation: [Int]!;
    var enemies: [SKSpriteNode] = [];
    var eHealth: [SKLabelNode] = [];
    var turnIndicator: SKLabelNode!;
    var enemyLocations: [CGPoint]!;
    var attackIndicator: SKSpriteNode!;
    var gestureArea: SKSpriteNode!;
    var indicatedIndex: Int = 0;
    var battleManger: STFBattleManager = STFBattleManager();
    var enemyActionInProgress = false;
    
    var skeletonPower = STGAttackStats(withCut: 20, andBlunt: 10, andShot: 0, andMagic: 0, andExplosive: 0);
    var skeletonDef = STGDefenceStats(withCut: 30, andBlunt: 0, andShot: 10, andMagic: 0, andExplosive: 0);
    var playerPower = STGAttackStats(withCut: 40, andBlunt: 10, andShot: 20, andMagic: 0, andExplosive: 10);
    
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
        
        turnIndicator = SKLabelNode(text: self.playerTurn);
        turnIndicator.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMaxY(self.frame)-100);
        addChild(turnIndicator);
        
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
    
    func endPlayerTurn(){
        battleManger.isEnemyTurn = true;
        battleManger.currentEnemyInTurn = 0;
        battleManger.isPlayerTurn = false;
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
        
        if(battleManger.isPlayerTurn == false){
            return;
        }
        
        var touchLocation = recognizer.locationInView(recognizer.view)
        touchLocation = self.convertPointFromView(touchLocation)
        let node = self.nodeAtPoint(touchLocation);

        if(node.name == "command"){
            print("swipe");
            
            eHealth[indicatedIndex].text = String(Int(eHealth[indicatedIndex].text!)! - Int(self.playerPower.explosiveAttack-self.skeletonDef.explosiveDefence));
            self.endPlayerTurn();
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
    

    func animateDmg(node: SKSpriteNode) {
        node.removeAllActions();
        node.runAction(SKAction.animateWithTextures(
            self.takeDmgAnimationFrames,
            timePerFrame: 0.25,
            resize: false,
            restore: true),
            completion:{
                self.addAnimationToObj(node);
        })

    }
    
    
    func animateAttack(node: SKSpriteNode) {
        enemyActionInProgress = true;
        node.removeAllActions();
        node.runAction(SKAction.animateWithTextures(
            self.attackAnimationFrames,
            timePerFrame: 0.25,
            resize: false,
            restore: true),
            completion:{
                self.addAnimationToObj(node);
                self.enemyActionInProgress = false;
            })
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
        
        battleManger.currentEnemyInTurn = 0;

    }
   
    override func update(currentTime: CFTimeInterval) {

        //update turn indicator
        if(battleManger.isPlayerTurn && self.enemyActionInProgress == false){
            self.turnIndicator.text = playerTurn;
        }
        else
        {
            self.turnIndicator.text = enemyTurn
        }
        
        if(enemyActionInProgress == false && battleManger.isEnemyTurn == true){
            self.animateAttack(enemies[battleManger.currentEnemyInTurn]);
            
            battleManger.currentEnemyInTurn++;
            if(battleManger.currentEnemyInTurn >= enemies.count){
                battleManger.isEnemyTurn = false;
                battleManger.isPlayerTurn = true;
            }
        }
    }
}
