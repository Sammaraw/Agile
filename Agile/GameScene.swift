//
//  GameScene.swift
//  Agile
//
//  Created by Zixiao on 2017/12/25.
//  Copyright © 2017年 Zixiao. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    let bg = SKSpriteNode(imageNamed: "clouds")
    let pop = Card(number:Type.one)
    
    override func didMove(to view: SKView) {
        //bg.position = CGPoint(x: frame.size.width / 2,y: frame.size.height/2)
        
        bg.zPosition = Height.background.rawValue
        scene?.scaleMode = SKSceneScaleMode.resizeFill
        bg.position = CGPoint.zero
        bg.zPosition = Height.background.rawValue
        addChild(bg)
 
        let one = Card(number:Type.one)
        one.position = CGPoint(x: -130, y: 200)
        addChild(one)
        
        let three = Card(number:Type.three)
        three.position = CGPoint(x: 130, y: 200)
        addChild(three)
        
        let two = Card(number:Type.two)
        two.position = CGPoint(x: 0, y: 200)
        addChild(two)
        
        let five = Card(number:Type.five)
        five.position = CGPoint(x: -130, y: 0)
        addChild(five)
        
        let eight = Card(number:Type.eight)
        eight.position = CGPoint(x: 0, y: 0)
        addChild(eight)
        
        let thirteen = Card(number:Type.thirteen)
        thirteen.position = CGPoint(x: 130, y: 0)
        addChild(thirteen)
        
        let twenty = Card(number:Type.twenty)
        twenty.position = CGPoint(x: -130, y: -200)
        addChild(twenty)
        
        let coffee = Card(number:Type.coffee)
        coffee.position = CGPoint(x:0 , y : -200)
        addChild(coffee)
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
   
    
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let location = t.location(in: self)
            if let card = atPoint(location) as? Card {
                if t.tapCount == 2{
                    /*
                    if card.enlarged{
                       /*card.size.width = pop.size.width
                       card.size.height = pop.size.height*/
                        
                    }else{
                      /*card.size.height = self.size.height
                      card.size.width = self.size.width*/
                        
                    }
 */
                    card.enlarge()
                    return
                }
                if card.enlarged {return}
                card.zPosition = Height.move.rawValue
                card.position = location
                card.removeAction(forKey: "drop")
                card.run(SKAction.scale(to: 1.5, duration: 0.25), withKey: "pickup")
               
           }
            
        }
    }
    /*
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    */
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?){
        for t in touches{
            let new_place = t.location(in: self)
            if let old_place = atPoint(new_place) as? Card{
                if old_place.enlarged{return}
                old_place.position = new_place
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let location = t.location(in: self)
            if let card = atPoint(location) as? Card {
                if (card.enlarged){return}
                card.zPosition = Height.card.rawValue
                card.removeFromParent()
                addChild(card)
                card.position = location
                card.removeAction(forKey: "pickup")
                card.run(SKAction.scale(to: 1.0, duration: 0.25), withKey: "drop")
                
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
