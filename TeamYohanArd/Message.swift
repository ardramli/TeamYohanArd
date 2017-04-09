//
//  Message.swift
//  TeamYohanArd
//
//  Created by Obiet Panggrahito on 08/04/2017.
//  Copyright © 2017 ardMac. All rights reserved.
//

import Foundation

class Message {
    
    var id : Int
    var name : String
    var text : String
    
    init () {
        id = 0
        name = ""
        text = ""
    }
    
    init (anId : Int , aName : String , aText : String) {
        id = anId
        name = aName
        text = aText
    }
}
