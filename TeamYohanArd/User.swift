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
    var id : Int
//    var image = UIImage
    
    init () {
        name = ""
        id = 0
//        image = #imageLiteral(resourceName: "dictionary")
    }
    
    init (aName : String , anId : Int /*, anImage :UIImage*/) {
        name = aName
        id = anId
//        image = anImage
    }
}
