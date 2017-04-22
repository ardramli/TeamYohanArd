////
////  ViewController.swift
////  TeamYohanArd
////
////  Created by ardMac on 07/04/2017.
////  Copyright © 2017 ardMac. All rights reserved.
////
//
//import UIKit
//import FirebaseDatabase
//import FirebaseAuth
//
//class ViewController: UIViewController {
//    @IBOutlet weak var userTableView: UITableView!
//
//        var ref: FIRDatabaseReference!
//    
//        var lastId : Int = 2
//        var chats : [User] = []
//        var currentUser : String = ""
//
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//       
//        ref = FIRDatabase.database().reference()
//        
//        userTableView.delegate = self
//        userTableView.dataSource = self
//        
//        listenToFirebase()
//        //End of viewDidLoad
//        
//         print("UID -> \(FIRAuth.auth()?.currentUser?.uid)")
//    }
//    
//    
//    func listenToFirebase () {
////        ref.child("Chats").observe(.childMoved, with: { (snapshot) in print ( "Moved :" , snapshot)
////        
////        })
//        
//        ref.child("Chats").observe(.childChanged, with: { (snapshot) in print ( "Changed :" , snapshot)
//            
//            guard let info = snapshot.value as? NSDictionary,
//                let messageId = Int(snapshot.key)
//                else {return}
//            
//            //get the age and name from the "info/ snapshot.value
//                guard let name = info["name"] as? String
//                else {return}
//            
//            if let matchedIndex = self.chats.index(where: {(messageElement) -> Bool in
//                return messageElement.id == messageId
//            }){
//                let changedMessage = self.chats[matchedIndex]
//                changedMessage.name = name
//                let indexPath = IndexPath(row: matchedIndex, section: 0)
//                self.userTableView.reloadRows(at: [indexPath], with: .fade)
//                
//            }
//            
//        })
//        
//        ref.child("Chats").observe(.childAdded, with: { (snapshot) in print ( "Added :" , snapshot)
//            
//            guard let info = snapshot.value as? NSDictionary
//                else {return}
//            
//            self.addChatToArray(id: snapshot.key, userInfo: info)
//            
//            if let lastUser = self.chats.last {
//                self.lastId = lastUser.id
//            }
//            
//            self.userTableView.reloadData()
//            
//            
////            let index = IndexPath(item: self.users.count - 1, section: 0)
////            self.userTableView.insertRows(at: [index], with: .left)
//            
//        })
//        
//        ref.child("Chats").observe(.childRemoved, with: { (snapshot) in print ( "Removed :" , snapshot)
//            
//            guard let deletedId = Int(snapshot.key)
//                else { return }
//            
//            if let deletedIndex = self.chats.index (where : { (std) -> Bool in
//                return std.id == deletedId
//            }) {
//                self.chats.remove(at: deletedIndex)
//                let indexPath = IndexPath(row: deletedIndex, section: 0)
//                self.userTableView.deleteRows(at: [indexPath], with: .right)
//            }
//        })
//            
//    //End of listenToFirebase
//    }
//
//    
//    func addChatToArray (id : Any , userInfo : NSDictionary) {
//        if  let name = userInfo ["name"] as? String,
//            let id = id as? String {
//            
//            let currentId = Int(id)
//            let newChat = Chat (aName: name, anId: currentId!)
//            self.chats.append(newChat)
//        }
//    }
//
//    @IBAction func logoutButtonTapped(_ sender: Any) {
//        
//        let firebaseAuth = FIRAuth.auth()
//        do {
//            try firebaseAuth?.signOut()
//            
//            //logged out and go to the log in page
//            if let logInVC = storyboard?.instantiateViewController(withIdentifier: "ToLogInNaviController") {
//                present(logInVC, animated: true, completion: nil)   }
//            
//        } catch let signOutError as NSError {
//            print ("Error signing out: %@", signOutError)
//        }
//    }
//    
//    @IBAction func startAChatButtonTapped(_ sender: Any) {
//        if let startAChat = storyboard?.instantiateViewController(withIdentifier: "UsersListViewController") {
//            navigationController?.pushViewController(startAChat, animated: true)
//        }
//    }
//
////End of ViewController Class
//}
//
//
//extension ViewController : UITableViewDelegate, UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return chats.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserTableViewCell
//            else {return UITableViewCell () }
//        
//        let currentUser = chats [indexPath.row]
//        cell.nameLabel.text = currentUser.name
//        print("User :",currentUser.name)
//        //cell.userImage.image = currentUser.image
//        //here is the place to implement the code to show a bit of the latest message received
//        
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        let currentStoryboard = UIStoryboard (name: "Main", bundle: Bundle.main)
//        if let targetViewController = currentStoryboard .instantiateViewController(withIdentifier: "ContentViewController") as? ContentViewController {
//            navigationController?.pushViewController(targetViewController, animated: true)
//        }
//    }
//    
//    
//// End of extention
//}
//
////change User.swift to Chat
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
