//
//  ProfileSettings.swift
//  MovieApp
//
//  Created by Vlad on 01.10.2020.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseDatabase

class ProfileSettings{
    
    //  id користувача в firabase
    private var userId = Auth.auth().currentUser?.uid
    // делегат в якому зняходять методи для передавання картинки і ім'я користувача
    private var delegate: ProfileDelegate?
    
    // набір значень для таблиці в профілю користувача
    enum SettingsItem:String, CaseIterable{
        case Favorites
        case AboutUs
        case Settings
        case Exit
    }
    
    public init(delegate:ProfileDelegate){
        self.delegate = delegate
    }
    
    // метод отримує ім'я користувача і передає його в делегат ProfileDelegate для передачі в VC
    func getUserName(){
        DispatchQueue.main.async {
            if let userId = self.userId{
                Database.database().reference().child("\(userId)").observe(DataEventType.value) { (response) in
                    let value = response.value as? NSDictionary
                    let username = value?["username"] as? String ?? "hello"

                    self.delegate?.GetName(name: username)
                }
            }
        }
    }
    // метод отримує картинку і передає його в делегат ProfileDelegate для передачі в VC
    func getImage(){
        DispatchQueue.main.async {
            if let userId = self.userId{
                let storageRef = Storage.storage().reference()
                let thisUserPhotoStorageRef = storageRef.child("\(userId)").child("profileImage")
                thisUserPhotoStorageRef.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
                    if let error = error {
                        // Uh-oh, an error occurred!
                        print("\(error)")
                    } else {
                        // Data for "images/island.jpg" is returned
                        if let data = data{
                            guard let image = UIImage(data: data) else {return}
                            self.delegate?.GetImage(image: image)
                        }
                    }
                }
            }
        }
    }
}

protocol ProfileDelegate{
    //метод для передачі картинки
    func GetImage(image:UIImage)
    //метод для передачі ім'я користувача
    func GetName(name:String)
}
