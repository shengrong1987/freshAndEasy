//
//  ItemLO.swift
//  FreshAndEasy
//
//  Created by sheng rong on 15/5/26.
//  Copyright (c) 2015年 Aimbebe. All rights reserved.
//

import Foundation
import SpriteKit

protocol ItemLogicCoreProtocol
{
    var beforeAction : String? { get set }
    var onGoingAction : Array< Dictionary <String,String> >? { get set }
    var afterAction : String? { get set }
    func beforeHandler()
    func onGoingHandler()
    func afterHandler()
}

class Item : SKSpriteNode,ItemLogicCoreProtocol {
    
    var id : String
    var desc : String
    var status : Enumertations.Status
    var texturename : String
    var enable : Bool
    var dragable : Bool
    var beforeAction : String?
    var onGoingAction : Array< Dictionary <String,String> >?
    var afterAction : String?
    var listingList : Array < Item >
    
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        self.desc = ""
        self.status = Enumertations.Status.INACTIVE
        self.texturename = ""
        self.enable = false
        self.dragable = false
        self.id = ""
        self.listingList = Array()
        super.init(texture: texture, color: color, size:size)
    }
    
    convenience init(id:String, desc:String, texturename:String, status: Enumertations.Status, enable: Bool, dragable:Bool, beforeAction:String, onGoingAction:Array< Dictionary < String, String> >, afterAction:String){
        let color = UIColor()
        let texture = SKTexture(imageNamed: texturename)
        self.init(texture: texture, color: color, size:CGSizeZero)
        self.id = id
        self.desc = desc
        self.texturename = texturename;
        self.enable = enable;
        self.status = status;
        self.dragable = dragable;
        self.beforeAction = beforeAction;
        self.onGoingAction = onGoingAction;
        self.afterAction = afterAction;
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func beforeHandler(){
        if let before = self.beforeAction {
            if before.hasPrefix("effects"){
                let effectname = before.componentsSeparatedByString("-")[1]
                self.playEffect(effectname, finish: { (isFinished:Bool) -> () in
                    if isFinished{
                        self.onGoingHandler()
                    }else{
                        let id = self.id
                        let desc = self.desc
                        println("item of id \(id) and desc \(desc),can not play effect \(effectname)");
                        self.onGoingHandler()
                    }
                })
            }
        }
    }
    
    func onGoingHandler(){
        if let statusArr = self.onGoingAction {
            var defaultCondition:String?
            var passAllCondition:Bool = true
            
            for status in statusArr{
                if let condition = status["condition"]{
                    //check all the non-default conditions
                    if condition != "default" {
                        let mutilConditions:Array = condition.componentsSeparatedByString(",")
                        var passOneConditionSet:Bool = true
                        for singleCondition in mutilConditions{
                            if singleCondition != ""{
                                let conditionArr = singleCondition.componentsSeparatedByString("-")
                                let item = conditionArr[0]
                                let itemstatus = conditionArr[1]
                                if true{
                                    
                                }else{
                                    passOneConditionSet = false
                                    //checkItemAndStatus fail
                                    self.bounds()
                                }
                            }
                        }
                        if passOneConditionSet {
                            //checkItemAndStatus pass
                            if let actionName = status["action"]{
                                self.checkAction(actionName)
                            }else{
                                //nothing happen
                            }
                            break
                        }else{
                            passAllCondition = false
                        }
                    }
                }else{
                    //directly run action when condition is empty
                    if let actionName = status["action"]{
                        self.checkAction(actionName)
                    }
                }
            }
            
            //run the default action if other conditions all fail to pass
            if !passAllCondition{
                for status in statusArr{
                    if status["condition"] == "default"{
                        if let actionName = status["action"]{
                            self.checkAction(actionName)
                        }else{
                            //nothing happen
                        }
                    }else{
                        self.bounds()
                    }
                }
            }
        }
    }
    
    func afterHandler(){
        
    }
    
    func checkAction(actionName:String){
        //check the action part of status
        self.doAction(actionName, finish: { (isFinished) -> () in
            if isFinished{
                self.afterHandler()
            }else{
                let id = self.id
                let desc = self.desc
                println("item of id \(id) and desc \(desc),can not play action \(actionName)");
                self.afterHandler()
            }
        })
    }
    
    func playEffect(name:String,finish:(Bool)->()){
        //play effect of the name
        finish(true)
    }
    
    func doAction(name:String,finish:(Bool)->()){
        //doAction
        finish(true)
    }
    
    func bounds(){
        
    }
}
