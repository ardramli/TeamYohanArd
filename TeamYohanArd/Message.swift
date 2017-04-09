//
//  Message.swift
//  TeamYohanArd
//
//  Created by Obiet Panggrahito on 08/04/2017.
//  Copyright © 2017 ardMac. All rights reserved.
//

import Foundation

class Message {
    
    var id : String
    var name : String
    var text : String
    
    init () {
        id = ""
        name = ""
        text = ""
    }
    
    init (anId : String , aName : String , aText : String) {
        id = anId
        name = aName
        text = aText
    }
}
