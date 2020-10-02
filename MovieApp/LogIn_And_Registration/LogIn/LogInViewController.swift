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
    
    //кнопка для входу за допомогою google акаунта
    @IBOutlet weak var signInWithGoogleButton: GIDSignInButton!
    @IBOutlet weak var logInButton: UIButton!
    
    //об'кт в якому метод для входу в систему
    private let logInSettings = LogInSettings()
    
    //custom activityIndicator
    private let activityIndicatorView = ActivityIndicator()

    override func viewDidLoad() {
        super.viewDidLoad()
        //підписуємся під делегат для показу вікна з входом за домогою google акаунта
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
        
        // добавляємо tap по екрану для скриття клавіатури
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        self.view.addGestureRecognizer(tap)
    }

    //після натискання кнопки визивається метод для входу в систему, якщо користувач зайшов в систему переходим до TabBarViewController 
    @IBAction func LogInButtonClick(_ sender: UIButton) {
        self.present(self.activityIndicatorView.alert, animated: true, completion: nil)
        if let email = self.emailAdress.text, let password = self.password.text{
            self.logInSettings.LogIn(email: email, password: password) { (result) in
                if result == true{
                    self.activityIndicatorView.alert.dismiss(animated: true, completion: nil)
                    // if user is login, move to UserNameViewController
                    let stroryboard = UIStoryboard(name: "TabBar", bundle: nil)
                    let tabTarVC = stroryboard.instantiateViewController(withIdentifier: "TabBarViewController")
                    tabTarVC.modalPresentationStyle = .fullScreen
                    self.present(tabTarVC, animated: true, completion: nil)
                }else{
                    self.activityIndicatorView.alert.dismiss(animated: true) {
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

