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
    var imageURL : String
//    var uid : String
    
    init () {
        name = ""
        imageURL = ""
//        uid = ""
    }
    
    init (aName : String , anImageURL : String /*, anUid : String*/) {
        name = aName
        imageURL = anImageURL
//        uid = anUid
    }
}
