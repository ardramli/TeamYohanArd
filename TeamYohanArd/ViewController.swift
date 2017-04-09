//
//  ViewController.swift
//  TeamYohanArd
//
//  Created by ardMac on 07/04/2017.
//  Copyright © 2017 ardMac. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {
    @IBOutlet weak var userTableView: UITableView!

        var ref: FIRDatabaseReference!
        var lastId : Int = 2
        var users : [User] = []
        var messages : [Message] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        ref = FIRDatabase.database().reference()
        
        userTableView.delegate = self
        userTableView.dataSource = self
        
        listenToFirebase()
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
                self.userTableView.reloadRows(at: [indexPath], with: .fade)
                
            }
            
        })
        
        ref.child("messages").observe(.childAdded, with: { (snapshot) in print ( "Added :" , snapshot)
            
            guard let info = snapshot.value as? NSDictionary
                else {return}
            
            self.addMessageToArray(id: snapshot.key, messageInfo: info)
            
            self.users.sort(by: { (ard, yohan) -> Bool in
                return ard.id < yohan.id
            })
            
            if let lastUser = self.users.last {
                self.lastId = lastUser.id
            }
            
            self.userTableView.reloadData()
            
            
            let index = IndexPath(item: self.users.count, section: 0)
            self.userTableView.insertRows(at: [index], with: .left)
            
        })
        
        ref.child("messages").observe(.childRemoved, with: { (snapshot) in print ( "Removed :" , snapshot)
            
        })
        
    //End of listenToFirebase
    }
    
    func addMessageToArray (id : Any , messageInfo : NSDictionary) {
        if  let name = messageInfo ["name"] as? String,
            let text = messageInfo ["text"] as? String {
            
            let newMessage = Message (anId: id as! Int, aName: name, aText: text)
            self.messages.append(newMessage)
        }
    }


//End of ViewController Class
}


extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserTableViewCell
            else {return UITableViewCell () }
        
        let currentUser = users [indexPath.row]
        cell.nameLabel.text = currentUser.name
        //cell.userImage.image = currentUser.image
        //here is the place to implement the code to show a bit of the latest message received
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentStoryboard = UIStoryboard (name: "Main", bundle: Bundle.main)
        if let targetViewController = currentStoryboard .instantiateViewController(withIdentifier: "ContentViewController") as? ContentViewController {
            navigationController?.pushViewController(targetViewController, animated: true)
        }
    }
    
    
// End of extention
}


















