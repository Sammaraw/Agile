//
//  Card.swift
//  Agile
//
//  Created by Zixiao on 2017/12/25.
//  Copyright © 2017年 Zixiao. All rights reserved.
//


import SpriteKit



enum Type:Int{
case two,
    one,
    three,
    five,
    eight,
    thirteen,
    twenty,
    coffee,
    question
}

enum Height:CGFloat{
    case background = 10,
    card = 100,
    move = 150,
    enlarged = 500
}


class Card : SKSpriteNode {
    let time: Type
    let front: SKTexture
    var enlarged = false
    var zeropoint = CGPoint.zero
    var oldpoint = CGPoint.zero
 
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    
    init(number:Type){
      self.time = number
      switch time{
      case .two:
        front = SKTexture(imageNamed:"2")
      case .one:
        front = SKTexture(imageNamed:"1")
      case .three:
        front = SKTexture(imageNamed:"3")
      case .five:
        front = SKTexture(imageNamed:"5")
      case .eight:
        front = SKTexture(imageNamed:"8")
      case .thirteen:
        front = SKTexture(imageNamed:"13")
      case .twenty:
        front = SKTexture(imageNamed:"20")
      case .coffee:
        front = SKTexture(imageNamed:"coffee")
      default:
        front = SKTexture(imageNamed:"1")
       }
        super.init(texture:front,color:.clear,size:front.size())
        self.zPosition = Height.card.rawValue
    }
    
    
    func enlarge(){
        if enlarged {
            enlarged = false
            
            self.zPosition = Height.card.rawValue
            position = oldpoint
            removeAllActions()
            setScale(1.0)
        }else{
            enlarged = true
            
            self.zPosition = Height.enlarged.rawValue
            oldpoint = position
            position = zeropoint
            removeAllActions()
            setScale(4.0)
        }
        
    }
    
    
    
    //not sure about clear color here
        

    
}
