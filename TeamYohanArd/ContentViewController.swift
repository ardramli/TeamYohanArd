//
//  ContentViewController.swift
//  TeamYohanArd
//
//  Created by Obiet Panggrahito on 08/04/2017.
//  Copyright © 2017 ardMac. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ContentViewController: UIViewController {
    @IBOutlet weak var masageTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!

    var ref: FIRDatabaseReference!
    
    var messages : [Message] = []
    
    @IBAction func sendButton(_ sender: Any) {
        if let message = messageTextField.text {
            print("id : \(lastId)")
            lastId = chatId + 1
            
            let post : [String : Any] = ["chatText" : chatText]
            ref.child("message").child("\(chatId)").updateChildValues(post)
        }
        else {
            print("Error updating chat")
        }
    //End of sendButton
    }
    
    func addMessageToArray (id : Any , messageInfo : NSDictionary) {
        if  let name = messageInfo ["name"] as? String,
            let text = messageInfo ["text"] as? String {
            
            let newMessage = Message (anId: id as! String, aName: name, aText: text)
            self.messages.append(newMessage)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        
        //navigationItem.title = currentUser.name
       
    //End of viewDidLoad
    }

    
//End of ContentViewController
}
