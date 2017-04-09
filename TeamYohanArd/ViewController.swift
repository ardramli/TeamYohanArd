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
    
        var users : [User] = []
    
        var currentUser : String = ""
    
        var lastId : Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        ref = FIRDatabase.database().reference()
        
        userTableView.delegate = self
        userTableView.dataSource = self
        
        listenToFirebase()
        //End of viewDidLoad
    }
    
    
    func listenToFirebase () {
        ref.child("yourPath").observe(.childMoved, with: { (snapshot) in print ( "Moved :" , snapshot)
        
        })
        
        ref.child("yourPath").observe(.childChanged, with: { (snapshot) in print ( "Changed :" , snapshot)
            
        })
        
        ref.child("yourPath").observe(.childAdded, with: { (snapshot) in print ( "Added :" , snapshot)
            
        })
        
        ref.child("yourPath").observe(.childRemoved, with: { (snapshot) in print ( "Removed :" , snapshot)
            
            guard let deletedId = Int(snapshot.key)
                else { return }
            
            if let deletedIndex = self.users.index (where : { (std) -> Bool in
                return std.id == deletedId
            }) {
                self.students.remove(at: deletedIndex)
                let indexPath = IndexPath(row: deletedIndex, section: 0)
                self.studentTableView.deleteRows(at: [indexPath], with: .right)
            }
        })
            
    //End of listenToFirebase
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


















