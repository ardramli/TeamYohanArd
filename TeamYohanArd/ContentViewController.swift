//
//  ContentViewController.swift
//  TeamYohanArd
//
//  Created by Obiet Panggrahito on 08/04/2017.
//  Copyright © 2017 ardMac. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class ContentViewController: UIViewController {
    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    @IBOutlet weak var addButton: UIButton! {
        didSet {
        addButton.addTarget(self, action: #selector(openImagePicker(_:)), for: .touchUpInside)
        }
    }

    var ref: FIRDatabaseReference!
    
    var messages : [Message] = []
    
    var fromUserId : Int = 0
    var toUserId : Int = 0
    
    var lastMessageId : Int = 2
    
    @IBAction func sendButton(_ sender: Any) {
        if let message = messageTextField.text {
            print("id : \(lastMessageId)")
            lastMessageId = lastMessageId + 1
            
            let post : [String : Any] = ["message" : message]
            ref.child("messages").child("\(lastMessageId)").updateChildValues(post)
        }
        else {
            print("Error updating chat")
        }
    //End of sendButton
    }
    

    func addMessageToArray (id : Any , messageInfo : NSDictionary) {
        
        //let fromId = messageInfo ["fromId"] as? Int,
        //let toId = messageInfo ["toId"] as? Int,
        //
        
        
        if let text = messageInfo ["message"] as? String,
            let messageId = id as? String {
           
            let currentChatId = Int(messageId)
            let newMessage = Message(afromId: 0, atoId: 0, aText: text, anId: currentChatId!)
            self.messages.append(newMessage)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        
        messageTableView.delegate = self
        messageTableView.dataSource = self
        
        //navigationItem.title = currentUser.name
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
                let _ = info["name"] as? String
                else {return}
            
            if let matchedIndex = self.messages.index(where: {(messageElement) -> Bool in
                return messageElement.id == messageId
            }){
                let changedMessage = self.messages[matchedIndex]
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
            
            
//            let index = IndexPath(item: self.messages.count, section: 0)
//            self.messageTableView.insertRows(at: [index], with: .left)
            
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
    
    
    func openImagePicker(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func dismissImagePicker(){
        dismiss(animated: true, completion: nil)
    }
    
    func uploadImage(_ image: UIImage) {
        
        let ref = FIRStorage.storage().reference()
        guard let imageData = UIImageJPEGRepresentation(image, 0.5) else {return}
        let metaData = FIRStorageMetadata()
        ref.child("chatImage.jpeg").put(imageData, metadata: metaData) { (meta, error) in
            
            if let downloadPath = meta?.downloadURL()?.absoluteString {
                //save to firebase database
                saveImagePath(downloadPath)
                
            }
            
        }
        
    }
    
    let dateFormat : DateFormatter = {
        let _dateFormatter = DateFormatter()
        let locale = Locale(identifier: "en_US_POSIX")
        _dateFormatter.locale = locale
        _dateFormatter.dateFormat = "yyyy'-'MM'-dd'T'HH':'mm':'ss'Z'"
        return _dateFormatter
    }()
    
    func saveImagePath(_ path: String) {
        let dbRef = FIRDatabase.database().reference()
        
        let chatValue : [String: Any] = ["name" : "ard",
                                         "timestamp": dateFormat.string(from: Date()),
                                         "imageURL": path]
        dbRef.child("chats").childByAutoId().setValue(chatValue)
    }
//End of ContentViewController
}

extension ContentViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //go to defer whenever exiting the function
        defer {
            dismissImagePicker()
        }
        
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else {
            return
        }
        uploadImage(image)
    }
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

