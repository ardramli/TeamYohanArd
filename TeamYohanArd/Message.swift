//
//  Message.swift
//  TeamYohanArd
//
//  Created by Obiet Panggrahito on 08/04/2017.
//  Copyright © 2017 ardMac. All rights reserved.
//

import Foundation

class Message {
    
    var fromId : Int
    var toId : Int
    var text : String
    var id : Int
    
    init () {
        fromId = 0
        toId = 0
        text = ""
        id = 0
    }
    
    init (afromId : Int, atoId : Int,  aText : String, anId : Int) {
        fromId = afromId
        text = aText
        toId = atoId
        id = anId
        
    }
}
