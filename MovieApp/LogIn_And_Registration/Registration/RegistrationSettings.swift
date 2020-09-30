//
//  RegistrationSettings.swift
//  MovieApp
//
//  Created by Vlad on 30.09.2020.
//

import Foundation
import FirebaseAuth

class RegistrationSettings{
    
    private let logIn = LogInSettings()
    
    func Registration(email:String,password:String, complition: @escaping (Bool)->Void){
        DispatchQueue.main.async {
            // create user
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if result != nil{
                    //if user created log in user
                    self.logIn.LogIn(email: email, password: password) { (result) in
                        if result == true{
                            complition(true)
                        }else{
                            complition(false)
                        }
                    }
                    
                }else{
                    complition(false)
                }
            }
        }
    }
}

