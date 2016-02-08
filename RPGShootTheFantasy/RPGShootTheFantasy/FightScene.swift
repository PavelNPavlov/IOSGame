//
//  GameScene.swift
//  RPGShootTheFantasy
//
//  Created by Pavel Pavlov on 2/3/16.
//  Copyright (c) 2016 Pavel Pavlov. All rights reserved.
//

import SpriteKit
import AVFoundation

class FightScene: SKScene {
    
    // Constants
    
    let wizard = "wizard";
    let ork = "ork";
    let skeleton = "skeleton";
    
    let playerTurn = "Player Turn";
    let enemyTurn = "Enemy Turn";
    
    let skeletonFrameCount = [8,4,3];
    let orkFrameCount = [4,4,2];
    let wizardFrameCount = [3,3,2];

    var navigation: UINavigationController!;
    var location: String!;
    var atlasName: String!;
    var idleAnimationFrames: [SKTexture]!;
    var attackAnimationFrames: [SKTexture]!;
    var takeDmgAnimationFrames: [SKTexture]!;
    var animSeparation: [Int]!;
    var enemies: [SKSpriteNode] = [];
    var eHealth: [SKLabelNode] = [];
    var turnIndicator: SKLabelNode!;
    var playerHealth: SKLabelNode!;
    var enemyLocations: [CGPoint]!;
    var attackIndicator: SKSpriteNode!;
    var gestureArea: SKSpriteNode!;
    var indicatedIndex: Int = 0;
    var battleManger: STFBattleManager = STFBattleManager();
    var enemyActionInProgress = false;
    var player: STFPlayer!;
    var backgroundImageName: String!;
    var remainingEnemies = 3;
    var scaleS = 1.0;
    
    //sound effects
    var enemyAttack: AVAudioPlayer!;
    var enemyHit: AVPlayer!;
    var bgMusic: AVPlayer!;
    
    var navigated = false;
    var skeletonPower = STGAttackStats(withCut: 20, andBlunt: 20, andShot: 0, andMagic: 0, andExplosive: 0);
    var skeletonDef = STGDefenceStats(withCut: 30, andBlunt: 0, andShot: 10, andMagic: 0, andExplosive: 0);
    var gameManger: STFGameManager!;
    override func didMoveToView(view: SKView) {
      
        view.backgroundColor = UIColor.whiteColor();
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        gameManger = appDelegate.gameManager;
        
        player = gameManger.player;
        // Get EnemyType
        self.setUpBackground();
      
        switch location{
        case "forest":
            self.atlasName = ork;
            animSeparation = orkFrameCount;
            scaleS = 0.75;
            break;
        case "dungeon":
            self.atlasName = wizard;
            animSeparation = wizardFrameCount;
            break;
        case "sewer":
            self.atlasName = skeleton
            animSeparation = skeletonFrameCount;
            break;
        default:
            print("Something went wrong with enemy type selection");
            break;
        }
        self.setUpAudio();
        let animateAtlas = SKTextureAtlas(named: self.atlasName);
        
        turnIndicator = SKLabelNode(text: self.playerTurn);
        turnIndicator.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMaxY(self.frame)-100);
        turnIndicator.fontName = "PingFang SC Semibold" ;
        addChild(turnIndicator);
        
        playerHealth = SKLabelNode(text: String(player.health));
        playerHealth.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMaxY(self.frame)-150);
        playerHealth.fontName = "PingFang SC Semibold" ;
        addChild(playerHealth);

        
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
        
        self.attackIndicator = SKSpriteNode(imageNamed: "arrow2");
        attackIndicator.xScale = 0.5;
        attackIndicator.yScale = 0.5;
        addChild(attackIndicator);
        
        self.makeEnemies(0);
        
        let gestureRecognizerSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipe:"))
       
        self.view!.addGestureRecognizer(gestureRecognizerSwipe)
         gestureRecognizerSwipe.direction = [.Left,.Right];
        
        
        let gestureRecognizerPinch = UIPinchGestureRecognizer(target: self, action: Selector("handlePinch:"))
        self.view!.addGestureRecognizer(gestureRecognizerPinch)
        
        let gesturRecogRotate = UIRotationGestureRecognizer(target: self, action: Selector("handleRotate:"))
        self.view!.addGestureRecognizer(gesturRecogRotate)
        
        let gesturRecogLong = UILongPressGestureRecognizer(target: self, action: Selector("handleLong:"))
        self.view!.addGestureRecognizer(gesturRecogLong)
        
        let gesturePan = UIPanGestureRecognizer(target: self, action: Selector("handlePan:"))
        self.view!.addGestureRecognizer(gesturePan)

        
        
        
        gestureArea = SKSpriteNode(imageNamed: "gesture2");
        gestureArea.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame)-200);
        gestureArea.name = "command";
        
        
        addChild(gestureArea);
        
        
    }
    
    func setUpAudio(){
            let path1 = NSBundle.mainBundle().resourcePath!+"/" + atlasName + "Attack.mp3";
            let url1 = NSURL(fileURLWithPath: path1);
            do{
                enemyAttack = try AVAudioPlayer(contentsOfURL: url1);
            }
            catch {
                print(" Sound Error");
            }
            enemyAttack.numberOfLoops = 0;
    }
    
    func setUpBackground(){
        let background = SKSpriteNode(imageNamed: self.location);
        background.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame));
        background.size = self.frame.size;
        
        addChild(background);
    }
    
    func endPlayerTurn(){
        battleManger.currentEnemyInTurn = 0;
        battleManger.isPlayerTurn = false;
        self.animateDmg(enemies[indicatedIndex]);
    }
    func handlePan(recognizer: UIPanGestureRecognizer) {
        
        if(recognizer.state != .Ended){
            return;
        }
        
        print("Pan");
        var touchLocation = recognizer.locationInView(recognizer.view)
        touchLocation = self.convertPointFromView(touchLocation)
        let node = self.nodeAtPoint(touchLocation);
        
        if(node.name == "command"){
            print("rotate");
            
            
            let dmg = Int(self.player.getAttack().cutAttack - self.skeletonDef.cutDefence);
            if(dmg>0){
                eHealth[indicatedIndex].text = String(Int(eHealth[indicatedIndex].text!)! - dmg);
            }
            if(Int(eHealth[indicatedIndex].text!)<=0){
                remainingEnemies--;
            }
            
            self.endPlayerTurn();
        }
    }

    
    
    func handleRotate(recognizer: UIRotationGestureRecognizer) {
        
        if(recognizer.state != .Ended){
            return;
        }
        
        print("Pinch");
        var touchLocation = recognizer.locationInView(recognizer.view)
        touchLocation = self.convertPointFromView(touchLocation)
        let node = self.nodeAtPoint(touchLocation);
        
        if(node.name == "command"){
            print("rotate");
            
            
            let dmg = Int(self.player.getAttack().shotAttack - self.skeletonDef.shotDefence);
            if(dmg>0){
                eHealth[indicatedIndex].text = String(Int(eHealth[indicatedIndex].text!)! - dmg);
            }
            if(Int(eHealth[indicatedIndex].text!)<=0){
                remainingEnemies--;
            }
            
            self.endPlayerTurn();
        }
    }
    
    func handleRhandleLongtate(recognizer: UILongPressGestureRecognizer) {
        
        if(recognizer.state != .Ended){
            return;
        }
        
        print("Long");
        var touchLocation = recognizer.locationInView(recognizer.view)
        touchLocation = self.convertPointFromView(touchLocation)
        let node = self.nodeAtPoint(touchLocation);
        
        if(node.name == "command"){
            print("rotate");
            
            
            let dmg = Int(self.player.getAttack().bluntAttack - self.skeletonDef.bluntDefence);
            if(dmg>0){
                eHealth[indicatedIndex].text = String(Int(eHealth[indicatedIndex].text!)! - dmg);
            }
            if(Int(eHealth[indicatedIndex].text!)<=0){
                remainingEnemies--;
            }
            
            self.endPlayerTurn();
        }
    }

    
    func handlePinch(recognizer: UIPinchGestureRecognizer) {
        
        if(recognizer.state != .Ended){
            return;
        }
      
        print("Rotate");
        var touchLocation = recognizer.locationInView(recognizer.view)
        touchLocation = self.convertPointFromView(touchLocation)
        let node = self.nodeAtPoint(touchLocation);
        
        if(node.name == "command"){
            print("pinch");
            
            
            let dmg = Int(self.player.getAttack().magicAttack - self.skeletonDef.magicDefence);
            if(dmg>0){
                eHealth[indicatedIndex].text = String(Int(eHealth[indicatedIndex].text!)! - dmg);
            }
            if(Int(eHealth[indicatedIndex].text!)<=0){
                remainingEnemies--;
            }

            self.endPlayerTurn();
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
            
            let dmg = Int(self.player.getAttack().explosiveAttack - self.skeletonDef.explosiveDefence)
            
            if(dmg>0){
                eHealth[indicatedIndex].text = String(Int(eHealth[indicatedIndex].text!)! - dmg);
            }
            
            if(Int(eHealth[indicatedIndex].text!)<=0){
                remainingEnemies--;
            }
        
            
            self.endPlayerTurn();
        }
    }
    
    func makeEnemies(count: Int){
        
        let firstFrame = self.idleAnimationFrames[0];
        

        
        let enemy1 = SKSpriteNode(texture: firstFrame);
        enemy1.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame)+100);
        enemy1.name = "e1";
        enemy1.setScale(CGFloat(scaleS))

        
        
        let enemy2 = SKSpriteNode(texture: firstFrame);
        enemy2.position = CGPoint(x: CGRectGetMidX(self.frame)+100, y: CGRectGetMidY(self.frame));
        enemy2.name = "e2";
         enemy2.setScale(CGFloat(scaleS))
//        
        let enemy3 = SKSpriteNode(texture: firstFrame);
        enemy3.position = CGPoint(x: CGRectGetMidX(self.frame)-100, y: CGRectGetMidY(self.frame));
        enemy3.name = "e3";
         enemy3.setScale(CGFloat(scaleS))
        
        
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
        
        for lable in eHealth{
            lable.fontName = "PingFang SC Semibold";
        }
        
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
                //self.animateAttack(self.enemies[self.battleManger.currentEnemyInTurn]);
                self.battleManger.isEnemyTurn = true;
        })

    }
    
    
    func animateAttack(node: SKSpriteNode) {
        enemyActionInProgress = true;
        node.removeAllActions();
        enemyAttack.play();
        node.runAction(SKAction.animateWithTextures(
            self.attackAnimationFrames,
            timePerFrame: 0.25,
            resize: false,
            restore: true),
            completion:{
                self.addAnimationToObj(node);
                self.enemyActionInProgress = false;
                let dmg = Int(self.player.getDefence().bluntDefence - self.skeletonPower.bluntAttack);
                
                print(dmg);
                if(dmg<0){
                    self.gameManger.player.health = self.gameManger.player.health+Double(dmg);
                    self.playerHealth.text = String(self.gameManger.player.health);
                    
                }

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

        if(gameManger.player.health<=0)
        {
            gameManger.player.health = 120;
            navigation.popViewControllerAnimated(true);
            navigated = true;
        }
        if(remainingEnemies==0 && !navigated){
            gameManger.player.level++;
            navigation.popViewControllerAnimated(true);
            navigated = true;
            return
        }
        var i: Int;
        for i=0; i<enemies.count; ++i{
            if(Int(eHealth[i].text!)!<=0){
                
                self.removeChildrenInArray([enemies[i]]);
                self.removeChildrenInArray([eHealth[i]]);
                                //enemies.removeAtIndex(i);
                //eHealth.removeAtIndex(i);
            
            }
        }
        //update turn indicator
        if(battleManger.isPlayerTurn && self.enemyActionInProgress == false){
            self.turnIndicator.text = playerTurn;
        }
        else
        {
            self.turnIndicator.text = enemyTurn
        }
        
        if(enemyActionInProgress == false && battleManger.isEnemyTurn == true){
            
            if(enemies[battleManger.currentEnemyInTurn].parent != nil){
                self.animateAttack(enemies[battleManger.currentEnemyInTurn]);
            }
            
            battleManger.currentEnemyInTurn++;
            if(battleManger.currentEnemyInTurn >= enemies.count){
                battleManger.isEnemyTurn = false;
                battleManger.isPlayerTurn = true;
            }
        }
    }
}
