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
    
    
    
    @IBAction func sendButton(_ sender: Any) {
    
        
        
    //End of sendButton
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
       
    //End of viewDidLoad
    }

    
//End of ContentViewController
}
