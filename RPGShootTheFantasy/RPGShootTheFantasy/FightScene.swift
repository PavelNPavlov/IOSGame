//
//  GameScene.swift
//  RPGShootTheFantasy
//
//  Created by Pavel Pavlov on 2/3/16.
//  Copyright (c) 2016 Pavel Pavlov. All rights reserved.
//

import SpriteKit

class FightScene: SKScene {
    
    var object : SKSpriteNode!;
    var atlasName: String!;
    var idleAnimationFrames: [SKTexture]!;
    var attackAnimationFrames: [SKTexture]!;
    var takeDmgAnimationFrames: [SKTexture]!;
    var animSeparation: [Int]!;
    
    override func didMoveToView(view: SKView) {
        
        
        let animateAtlas = SKTextureAtlas(named: self.atlasName);
        
        //init temp
        
        var attack = [SKTexture]();
        var idle = [SKTexture]();
        var take = [SKTexture]();
        
        //attack
        
        for var i=1; i<=self.animSeparation[0]; i++ {
            let textureName = atlasName+String(i);
            attack.append(animateAtlas.textureNamed(textureName))
        }
        
        //takeDmg
        
        for var i=1; i<=self.animSeparation[1]; i++ {
            let textureName = atlasName+String(i+self.animSeparation[0]);
            take.append(animateAtlas.textureNamed(textureName))
        }
        
        //idle
        
        for var i=1; i<=self.animSeparation[2]; i++ {
            let textureName = atlasName+String(i+self.animSeparation[0]+self.animSeparation[1]);
            idle.append(animateAtlas.textureNamed(textureName))
        }
        
        //setValues
        
        self.attackAnimationFrames = attack;
        self.idleAnimationFrames = idle;
        self.takeDmgAnimationFrames = take;
        
        //add obejct
        
        let firstFrame = self.idleAnimationFrames[0];
        
        self.object = SKSpriteNode(texture: firstFrame)
        self.object.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        addChild(self.object);

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

    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
