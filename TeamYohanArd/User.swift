//
//  User.swift
//  Pods
//
//  Created by Obiet Panggrahito on 08/04/2017.
//
//

import Foundation

class User {
    var name : String
    var picture : Image
    
    init () {
        name = ""
        picture = #imageLiteral(resourceName: "dictionary")
    }
    
    init (aName : String, aPicture :Image) {
        name = aName
        picture = aPicture
    }
}
