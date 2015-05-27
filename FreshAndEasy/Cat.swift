//
//  Cat.swift
//  FreshAndEasy
//
//  Created by sheng rong on 15/5/27.
//  Copyright (c) 2015年 Aimbebe. All rights reserved.
//

import Foundation
import SpriteKit

class Cat:Item{
    var currentState:State
    
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        self.currentState = CatStayState()
        super.init(texture: texture, color: color, size:size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeState(currentState:State){
        //make sure currentState and self.currentState are both valid states
        self.currentState.exitState(self)
        self.currentState = currentState
        self.currentState.enterState(self)
        self.update()
    }
    
    func update(){
        self.currentState.exitState(self)
    }
}