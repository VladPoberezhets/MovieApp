//
//  RegistrationViewController.swift
//  MovieApp
//
//  Created by Vlad on 28.09.2020.
//

import UIKit
import FirebaseAuth
import Firebase

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var registrationButton: UIButton!
    
    let activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
        
        TagGestureSettings()
        SettingsTextField()
    }
    
    
    // проверяем email на уникальность
    @IBAction func CheckEmail(_ sender: UITextField) {
        // добавляєм activityIndicator в textfiled з правої сторони
        self.email.rightView = activityIndicator
        activityIndicator.startAnimating()
        
        if sender.text != ""{
            //перевіряєм чи є зареєстрований користувач з таким email
            Auth.auth().fetchSignInMethods(forEmail: "\(sender.text!)") { (user, err) in
                if user == nil{
                    
                    self.SettingsViewItemCheckUITextField(textField: sender)
                    
                    // зупиняєм activity indicator
                    self.activityIndicator.stopAnimating()
                }else{
                    // міняємо колір бордера на червоний
                    self.SettingsViewItemErrorCheckUITextField(textField: sender)
                    
                    // зупиняєм activity indicator
                    self.activityIndicator.stopAnimating()
                }
                
            }
        }
    }
    
    @IBAction func checkPassword(_ sender: UITextField) {
        // добавляєм activityIndicator в textfiled з правої сторони
        self.password.rightView = self.activityIndicator
        self.activityIndicator.startAnimating()
        
        if sender.text!.count >= 6 {
            
            SettingsViewItemCheckUITextField(textField: sender)
            
            // зупиняєм activity indicator
            self.activityIndicator.stopAnimating()
        }else{
            // міняємо колір бордера на червоний
            SettingsViewItemErrorCheckUITextField(textField: sender)
            
            // зупиняєм activity indicator
            self.activityIndicator.stopAnimating()
        }
    }
    
    @IBAction func checkConfirmPassword(_ sender: UITextField) {
        // добавляєм activityIndicator в textfiled з правої сторони
        
        self.password.rightView = self.activityIndicator
        self.activityIndicator.startAnimating()
        
        if sender.text != email.text && !(sender.text?.isEmpty ?? true) && !(email.text?.isEmpty ?? true){
            
            SettingsViewItemCheckUITextField(textField: sender)
            
            registrationButton.isEnabled = true
            registrationButton.backgroundColor = UIColor.systemGreen
            // зупиняєм activity indicator
            self.activityIndicator.stopAnimating()
        }else{
            // міняємо колір бордера на червоний
            SettingsViewItemErrorCheckUITextField(textField: sender)
            // зупиняєм activity indicator
            self.activityIndicator.stopAnimating()
        }
    }
    
    @IBAction func RegistrationButtonClick(_ sender: UIButton) {
        DispatchQueue.main.async {
            Auth.auth().createUser(withEmail: self.email.text ?? "", password: self.password.text ?? "") { (result, error) in
                if result != nil{
                    Auth.auth().signIn(withEmail: self.email.text ?? "", password:self.password.text ?? "") { (result, error) in
                        if error == nil{
                            
                        }
                        
                    }
                    
                }else{
                    let alert = UIAlertController(title: "Error", message: "Please try again", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Continue", style: .cancel, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    @IBAction func GoToLogInView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


extension RegistrationViewController{
    func TagGestureSettings(){
        // добавляємо tap по екрану для скриття клавіатури
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        self.view.addGestureRecognizer(tap)
    }
    
    func SettingsTextField(){
        //настройки для добавляння view справа в textfiled
        email.rightViewMode = .always
        
        //padding In TextFieldView
        let paddingInTextFieldEmail = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: self.email.frame.height))
        email.leftView = paddingInTextFieldEmail
        email.leftViewMode = .always
        
        //настройки для добавляння view справа в textfiled
        password.rightViewMode = .always
        
        //padding In TextFieldView
        let paddingInTextFieldPassword = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: self.password.frame.height))
        password.leftView = paddingInTextFieldPassword
        password.leftViewMode = .always
        
        //настройки для добавляння view справа в textfiled
        confirmPassword.rightViewMode = .always
        
        //padding In TextFieldView
        let paddingInTextFieldConfirmPassword = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: self.password.frame.height))
        confirmPassword.leftView = paddingInTextFieldConfirmPassword
        confirmPassword.leftViewMode = .always
    }
    
    func SettingsViewItemCheckUITextField(textField:UITextField){
        
        // міняємо колір бордера на зелений
        textField.borderStyle = .none
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGreen.cgColor
        
        // встановлюєм картинку з правої сторони в texfield
        let imageView = UIImageView();
        if let image = UIImage(systemName: "checkmark.circle"){
            let tintableImage = image.withRenderingMode(.alwaysTemplate)
            imageView.image = tintableImage
        }
        imageView.tintColor = UIColor.systemGreen
        
        textField.rightView = imageView
        
    }
    
    func SettingsViewItemErrorCheckUITextField(textField:UITextField){
        // міняємо колір бордера на червоний
        textField.borderStyle = .none
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemRed.cgColor
        
        // встановлюєм картинку з правої сторони в texfield
        let imageView = UIImageView();
        if let image = UIImage(systemName: "multiply.circle"){
            let tintableImage = image.withRenderingMode(.alwaysTemplate)
            imageView.image = tintableImage
        }
        imageView.tintColor = UIColor.systemRed
        textField.rightView = imageView
    }
}
