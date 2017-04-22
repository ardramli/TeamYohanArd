//
//  UsersListViewController.swift
//  TeamYohanArd
//
//  Created by ardMac on 10/04/2017.
//  Copyright © 2017 ardMac. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class UsersListViewController: UIViewController {

    var ref: FIRDatabaseReference!
    var users : [User] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self as UITableViewDelegate
        tableView.dataSource = self as UITableViewDataSource
        ref = FIRDatabase.database().reference()
        listenToFirebase()
    }

    func listenToFirebase () {

        ref.child("Users").observe(.childAdded, with: { (snapshot) in print ( "Added :" , snapshot)
    
            
            
            guard let snapshotDictionary = snapshot.value as? NSDictionary
                else { return }
    
            let name = snapshotDictionary["name"] as? String
            let imageURL = snapshotDictionary["imageURL"] as? String ?? ""
            
            let newUser = User(aName: name!, anImageURL: imageURL, anUid: snapshot.key)
            self.users.append(newUser)
            self.tableView.reloadData()
            })
        }
    
    @IBAction func cancelButton(_ sender: Any) {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
}

extension UsersListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userListCell") as? UsersListTableViewCell
            else {return UsersListTableViewCell () }
        
        let user = users[indexPath.row]
        cell.nameLabel.text = user.name
        //cell.userImage.image = currentUser.image
       
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        //get user
        let user = users[indexPath.row]
        
   //     self.ref.child("Users").child(user.uid).child("messages").setValue( [Message.id : ""])
        
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    // End of extention
}

