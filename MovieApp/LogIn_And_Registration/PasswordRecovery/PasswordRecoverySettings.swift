//
//  PasswordRecoverySettings.swift
//  MovieApp
//
//  Created by Vlad on 30.09.2020.
//

import Foundation
import Firebase

class PasswordRecoverySettings{
    
    func PasswordRecovery(email:String, complition:@escaping (Bool)->Void){
        DispatchQueue.main.async {
            Auth.auth().sendPasswordReset(withEmail: email) { (error) in
                if error == nil{
                    complition(true)
                }else{
                    complition(false)
                }
            }
        }
    }
}
