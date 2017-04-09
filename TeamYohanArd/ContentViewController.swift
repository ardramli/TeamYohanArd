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
    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!

    var ref: FIRDatabaseReference!
    
    var messages : [Message] = []
    
    var fromUserId : Int = 0
    var toUserId : Int = 0
    
    var lastMessageId : Int = 2
    
    @IBAction func sendButton(_ sender: Any) {
        if let message = messageTextField.text {
            print("id : \(lastMessageId)")
            lastMessageId = lastMessageId + 1
            
            let post : [String : Any] = ["chatText" : message]
            ref.child("messages").child("\(lastMessageId)").updateChildValues(post)
        }
        else {
            print("Error updating chat")
        }
    //End of sendButton
    }
    

    func addMessageToArray (id : Any , messageInfo : NSDictionary) {
        if let text = messageInfo ["chatText"] as? String,
            let fromId = messageInfo ["fromId"] as? Int,
            let toId = messageInfo ["toId"] as? Int{
            
            let newMessage = Message (afromId: fromUserId, atoId: toUserId, aText: text)
            self.messages.append(newMessage)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        
        //navigationItem.title = currentUser.name
       
    //End of viewDidLoad
    }
    
    func listenToFirebase () {
        ref.child("messages").observe(.childMoved, with: { (snapshot) in print ( "Moved :" , snapshot)
            
        })
        
        ref.child("messages").observe(.childChanged, with: { (snapshot) in print ( "Changed :" , snapshot)
            
            guard let info = snapshot.value as? NSDictionary,
                let messageId = Int(snapshot.key)
                else {return}
            
            //get the age and name from the "info/ snapshot.value
            guard let text = info["text"] as? String,
                let name = info["name"] as? String
                else {return}
            
            if let matchedIndex = self.messages.index(where: {(messageElement) -> Bool in
                return messageElement.id == messageId
            }){
                let changedMessage = self.messages[matchedIndex]
                changedMessage.name = name
                changedMessage.text = text
                let indexPath = IndexPath(row: matchedIndex, section: 0)
                self.messageTableView.reloadRows(at: [indexPath], with: .fade)
                
            }
            
        })
        
        ref.child("messages").observe(.childAdded, with: { (snapshot) in print ( "Added :" , snapshot)
            
            guard let info = snapshot.value as? NSDictionary
                else {return}
            
            self.addMessageToArray(id: snapshot.key, messageInfo: info)
            
           
            
            if let lastMessage = self.messages.last {
                self.lastMessageId = lastMessage.id
            }
            
            self.messageTableView.reloadData()
            
            
            //            let index = IndexPath(item: self.users.count, section: 0)
            //            self.userTableView.insertRows(at: [index], with: .left)
            
        })
        
        ref.child("messages").observe(.childRemoved, with: { (snapshot) in print ( "Removed :" , snapshot)
            
            guard let deletedId = Int(snapshot.key)
                else { return }
            
            if let deletedIndex = self.messages.index (where : { (std) -> Bool in
                return std.id == deletedId
            }) {
                self.messages.remove(at: deletedIndex)
                let indexPath = IndexPath(row: deletedIndex, section: 0)
                self.messageTableView.deleteRows(at: [indexPath], with: .right)
            }
        })
        
        //End of listenToFirebase
    }

    
//End of ContentViewController
}




extension ContentViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell")
            else {return UITableViewCell () }
        
        let currentMessage = messages [indexPath.row]
        cell.textLabel?.text = currentMessage.text
        
        //cell.userImage.image = currentUser.image
        //here is the place to implement the code to show a bit of the latest message received
        
        return cell
    }
    
    
    
    // End of extention
}

