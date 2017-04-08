//
//  Message.swift
//  TeamYohanArd
//
//  Created by Obiet Panggrahito on 08/04/2017.
//  Copyright © 2017 ardMac. All rights reserved.
//

import Foundation

class Message {
    var name : String
    var text : String
    
    init () {
        name = ""
        text = ""
    }
    
    init (aName : String , aText : String) {
        name = aName
        text = aText
    }
}
