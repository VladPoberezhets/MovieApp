//
//  ProfileImageSettings.swift
//  MovieApp
//
//  Created by Vlad on 01.10.2020.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage

class ProfileImageSettings{
    //  id користувача в firabase
    private let userId = Auth.auth().currentUser?.uid
    
    // метод добавляє данi по ід користувача в базу даних firebase
    func addUserInfoToDataBase(userModel:UserModel){
        if let userId = userId{
            Database.database().reference().child("\(userId)").setValue(["username":userModel.username])
        }
    }
    
    // метод добавляє картінку в storage по id користувача firebase
    func setUsersPhoto(withImage: UIImage) {
        
        if let userId = userId{
            guard let imageData = withImage.jpegData(compressionQuality: 0.5) else { return }
            let storageRef = Storage.storage().reference()
            
            let userPhotoStorageRef = storageRef.child("\(userId)").child("profileImage")
            
            userPhotoStorageRef.putData(imageData, metadata: nil) { (metadata, error) in
                guard let metadata = metadata else {
                    print("error while uploading")
                    return
                }
                
                userPhotoStorageRef.downloadURL { (url, error) in
                    print(metadata.size) // Metadata contains file metadata such as size, content-type.
                    userPhotoStorageRef.downloadURL { (url, error) in
                        guard let downloadURL = url else {
                            print("an error occured after uploading and then getting the URL")
                            return
                        }
                        
                        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                        changeRequest?.photoURL = downloadURL
                        changeRequest?.commitChanges { (error) in
                            //handle error
                        }
                    }
                }
            }
        }
    }
}
