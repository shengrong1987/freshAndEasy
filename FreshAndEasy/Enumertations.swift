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
        case ACTIVE //Item's activated
        case STORE //Item's in bag
        case DISABLE // Item's not controlable
    }
    
    enum Action : String{
        case GET = "GET"
        case BOUND = "BOUND"
    }
}
