//
//  RegisterViewController.swift
//  TeamYohanArd
//
//  Created by ardMac on 10/04/2017.
//  Copyright © 2017 ardMac. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!

    
    var ref :FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = FIRDatabase.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        
        guard let email = emailTextField.text,
            let password = passwordTextField.text,
            let confirmPassword = confirmPasswordTextField.text
            else { return }
        
        //validation
        if email == "" || password == "" {
            print("Email / password cannot be empty")
        }
        
        if password != confirmPassword {
            print("Passwords aren't the same")
            return
        }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            // ...
            if let err = error {
                print("Sign Up error : \(err.localizedDescription)")
                return
            }
            
            guard let user = user
                else { print("User not found error")
                    return
            }
            print("User created")
            print("Email : \(user.email)")
            print("uid : \(user.uid)")
            
            //set a new value. when adding we do not need to use arrays
            let dict : [String : Any] = ["name" :  self.nameTextField.text!, "email" : self.emailTextField.text!, "display picture URL" : ""]
            self.ref.child("Users").child(user.uid).setValue(dict)
            
            if let goToViewController = self.storyboard?.instantiateViewController(withIdentifier: "ToViewNaviController") {
                self.present(goToViewController, animated: true, completion: nil)
            }
    }
}

    @IBAction func backButtonTapped(_ sender: Any) {
        
        let _ = navigationController?.popViewController(animated: true)
    }
    
    
}
