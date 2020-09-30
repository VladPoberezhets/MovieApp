//
//  LogInSettings.swift
//  MovieApp
//
//  Created by Vlad on 30.09.2020.
//

import Foundation
import FirebaseAuth

class LogInSettings{
    
    func LogIn(email:String,password:String,complition:@escaping (Bool)->Void){
        if !email.isEmpty && !password.isEmpty{
            DispatchQueue.main.async {
                Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                    if result != nil{
                        complition(true)
                    }else{
                        complition(false)
                    }
                }
            }
        }
    }
}
