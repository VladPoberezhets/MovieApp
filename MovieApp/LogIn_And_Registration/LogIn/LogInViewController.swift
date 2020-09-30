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
    
    private let logInSettings = LogInSettings()

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
        if let email = self.emailAdress.text, let password = self.password.text{
            
            self.logInSettings.LogIn(email: email, password: password) { (result) in
                if result == true{
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

