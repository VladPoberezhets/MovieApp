//
//  PasswordRecoveryViewController.swift
//  MovieApp
//
//  Created by Vlad on 28.09.2020.
//

import UIKit
import FirebaseAuth
import Firebase

class PasswordRecoveryViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var recoveryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // добавляємо tap по екрану для скриття клавіатури
          let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
          self.view.addGestureRecognizer(tap)
          
          //настройки для добавляння view справа в textfiled
          email.rightViewMode = UITextField.ViewMode.always
          email.rightViewMode = .always
          
          //padding In TextFieldView
          let paddingInTextFieldView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: self.email.frame.height))
          email.leftView = paddingInTextFieldView
          email.leftViewMode = .always
    }
    

    @IBAction func checkEmail(_ sender: UITextField) {
        // добавляєм activityIndicator в textfiled з правої сторони
        let activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        self.email.rightView = activityIndicator
        activityIndicator.startAnimating()
        
        if sender.text != ""{
            //перевіряєм чи є зареєстрований користувач з таким email
            Auth.auth().fetchSignInMethods(forEmail: "\(sender.text!)") { (user, err) in
                if user != nil{
                    //робим кнопку активною і змінюєм її колір
                    self.recoveryButton.isEnabled = true
                    self.recoveryButton.backgroundColor = UIColor.systemPink
                    
                    // міняємо колір бордера на зелений
                    self.email.borderStyle = .none
                    self.email.layer.borderWidth = 1
                    self.email.layer.borderColor = UIColor.systemGreen.cgColor
                    
                    // встановлюєм картинку з правої сторони в texfield
                    let imageView = UIImageView();
                    if let image = UIImage(systemName: "checkmark.circle"){
                        let tintableImage = image.withRenderingMode(.alwaysTemplate)
                        imageView.image = tintableImage
                    }
                    imageView.tintColor = UIColor.systemGreen
                    
                    self.email.rightView = imageView
                    
                    // зупиняєм activity indicator
                    activityIndicator.stopAnimating()
                }else{
                    // міняємо колір бордера на червоний
                    self.email.borderStyle = .none
                    self.email.layer.borderWidth = 1
                    self.email.layer.borderColor = UIColor.systemRed.cgColor
                    
                    // встановлюєм картинку з правої сторони в texfield
                    let imageView = UIImageView();
                    if let image = UIImage(systemName: "multiply.circle"){
                        let tintableImage = image.withRenderingMode(.alwaysTemplate)
                        imageView.image = tintableImage
                    }
                    imageView.tintColor = UIColor.systemRed
                    self.email.rightView = imageView
                    
                    // зупиняєм activity indicator
                    activityIndicator.stopAnimating()
                }
                
            }
        }
    }
    
    @IBAction func recoveryButtonClick(_ sender: UIButton) {
        Auth.auth().sendPasswordReset(withEmail: email.text!) { (error) in
            if error == nil{
                let alert = UIAlertController(title: "Success", message: "Please check your email", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                //після 3 секунд закриваєм alet
                let when = DispatchTime.now() + 3
                DispatchQueue.main.asyncAfter(deadline: when){
                  alert.dismiss(animated: true, completion: nil)
                }
                self.dismiss(animated: true, completion: nil)
            }else{
                let alert = UIAlertController(title: "Error", message: "Please try again", preferredStyle: .alert)
                let action = UIAlertAction(title: "Continue", style: .cancel, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
