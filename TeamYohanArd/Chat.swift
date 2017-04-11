//
//  Chat.swift
//  TeamYohanArd
//
//  Created by Obiet Panggrahito on 11/04/2017.
//  Copyright © 2017 ardMac. All rights reserved.
//

import Foundation

class Chat {
    var name : String
    var id : Int
    
    init () {
        name = ""
        id = 0
    }
    
    init (aName : String, anId : Int) {
        name = aName
        id = anId
    }
}
