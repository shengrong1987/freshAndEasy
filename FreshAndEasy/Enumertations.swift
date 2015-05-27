//
//  Enumertations.swift
//  FreshAndEasy
//
//  Created by sheng rong on 15/5/26.
//  Copyright (c) 2015年 Aimbebe. All rights reserved.
//

import Foundation

class Enumertations{
    enum Status{
        case INACTIVE //Item's not activated
        case ON //Item's on
        case OFF //Item's off
        case STORE //Item's in bag
        case DROP //Item's dropped
        case DISABLE // Item's not controlable
    }
    
    enum Action : String{
        case GET = "GET" //take an item to the bag
        case BOUND = "BOUND" //reverse play the last animation
        case GONE = "GONE" //remove the item
    }
}
