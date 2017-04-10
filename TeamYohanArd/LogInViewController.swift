//
//  LogInViewController.swift
//  TeamYohanArd
//
//  Created by ardMac on 10/04/2017.
//  Copyright © 2017 ardMac. All rights reserved.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentUser = FIRAuth.auth()?.currentUser {
            //indicating that someone is logged in
            print("A user has logged in")
            //go to the main page
        }


    }


    
    @IBAction func logInButtonTapped(_ sender: Any) {
        
        guard let email = emailTextField.text,
            let password = passwordTextField.text
            else { return }
        
        if email == "" || password == "" {
            print ("input error : email / password cannot be empty")
            return
        }
        
        //paste from Sign in existing users in Authentication
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            // ...
            if let err = error {
                print("SignIn Error : \(err.localizedDescription)")
                return
            }
            
            guard let user = user
                else {
                    print("User Error")
                    return
            }
            
            print("User Logged In")
            print("email : \(user.email)")
            print("uid : \(user.uid)")

            self.directToMainNavigationController()
    }
    }
    
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        
        if let signUpVC = storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") {
            navigationController?.pushViewController(signUpVC, animated: true)
        }
    }

    func directToMainNavigationController () {
        if let mainNavi = storyboard?.instantiateViewController(withIdentifier: "ToViewNaviController") {
            present(mainNavi, animated: true, completion: nil)
        }
    }
}
