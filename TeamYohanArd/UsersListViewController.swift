//
//  UsersListViewController.swift
//  TeamYohanArd
//
//  Created by ardMac on 10/04/2017.
//  Copyright © 2017 ardMac. All rights reserved.
//

import UIKit

class UsersListViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

   
    }

   
    
}

extension UsersListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count //I cannot get users array from RegisterViewController
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userListCell")
            else {return UITableViewCell () }
        
        let currentUser = users [indexPath.row]
        cell.nameLabel.text = currentUser.text //I cannot get nameLabel from UsersListTableViewCell
        
        //cell.userImage.image = currentUser.image
        //here is the place to implement the code to show a bit of the latest message received
        
        return cell
    }
    
    
    
    // End of extention
}

