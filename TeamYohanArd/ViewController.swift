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
        var currentUser : String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        ref = FIRDatabase.database().reference()
        
        userTableView.delegate = self
        userTableView.dataSource = self
        
        listenToFirebase()
        //End of viewDidLoad
    }
    
    
    func listenToFirebase () {
        ref.child("users").observe(.childMoved, with: { (snapshot) in print ( "Moved :" , snapshot)
        
        })
        
        ref.child("users").observe(.childChanged, with: { (snapshot) in print ( "Changed :" , snapshot)
            
            guard let info = snapshot.value as? NSDictionary,
                let messageId = Int(snapshot.key)
                else {return}
            
            //get the age and name from the "info/ snapshot.value
            guard let text = info["text"] as? String,
                let name = info["name"] as? String
                else {return}
            
            if let matchedIndex = self.users.index(where: {(messageElement) -> Bool in
                return messageElement.id == messageId
            }){
                let changedMessage = self.users[matchedIndex]
                changedMessage.name = name
                changedMessage.text = text
                let indexPath = IndexPath(row: matchedIndex, section: 0)
                self.userTableView.reloadRows(at: [indexPath], with: .fade)
                
            }
            
        })
        
        ref.child("users").observe(.childAdded, with: { (snapshot) in print ( "Added :" , snapshot)
            
            guard let info = snapshot.value as? NSDictionary
                else {return}
            
            self.addUserToArray(id: snapshot.key, userInfo: info)
            
            self.users.sort(by: { (ard, yohan) -> Bool in
                return ard.id < yohan.id
            })
            
            if let lastUser = self.users.last {
                self.lastId = lastUser.id
            }
            
            self.userTableView.reloadData()
            
            
//            let index = IndexPath(item: self.users.count, section: 0)
//            self.userTableView.insertRows(at: [index], with: .left)
            
        })
        
        ref.child("users").observe(.childRemoved, with: { (snapshot) in print ( "Removed :" , snapshot)
            
            guard let deletedId = Int(snapshot.key)
                else { return }
            
            if let deletedIndex = self.users.index (where : { (std) -> Bool in
                return std.id == deletedId
            }) {
                self.users.remove(at: deletedIndex)
                let indexPath = IndexPath(row: deletedIndex, section: 0)
                self.userTableView.deleteRows(at: [indexPath], with: .right)
            }
        })
            
    //End of listenToFirebase
    }

    
    func addUserToArray (id : Any , userInfo : NSDictionary) {
        if  let name = userInfo ["name"] as? String,
            let text = userInfo ["text"] as? String,
            let id = id as? String {
            let currentId = Int(id)
            
            let newUser = User (aName: name, anId: currentId!, aText: text)
            self.users.append(newUser)
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
        cell.messageLabel.text = currentUser.text
        print("User :",currentUser.name)
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


















