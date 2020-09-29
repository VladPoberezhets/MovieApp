//
//  ViewController.swift
//  MovieApp
//
//  Created by Vlad on 28.09.2020.
//

import UIKit
import GoogleSignIn
import FirebaseAuth
import Firebase

class LogInViewController: UIViewController {
    
    @IBOutlet weak var emailAdress: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var signInWithGoogleButton: GIDSignInButton!
    @IBOutlet weak var logInButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
        
        // добавляємо tap по екрану для скриття клавіатури
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        self.view.addGestureRecognizer(tap)
    }

    @IBAction func LogInButtonClick(_ sender: UIButton) {
        if !emailAdress.text!.isEmpty && !password.text!.isEmpty{
            DispatchQueue.main.async {
                Auth.auth().signIn(withEmail: self.emailAdress.text!, password: self.password.text!) { (result, error) in
                    if result != nil{
                        print("user is login")
                    }else{
                        let alert = UIAlertController(title: "Error", message: "Incorect email or password", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Continue", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
            
            
        }
    }
    
}

