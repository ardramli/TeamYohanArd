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
    var text : String
    
//    var image = UIImage
    
    init () {
        name = ""
        id = 0
        text = ""
//        image = #imageLiteral(resourceName: "dictionary")
    }
    
    init (aName : String , anId : Int , aText : String/*, anImage :UIImage*/) {
        name = aName
        id = anId
        text = aText
//        image = anImage
    }
}
