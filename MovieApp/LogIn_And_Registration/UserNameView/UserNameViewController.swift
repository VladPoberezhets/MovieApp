//
//  UserNameViewController.swift
//  MovieApp
//
//  Created by Vlad on 30.09.2020.
//

import UIKit

class UserNameViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    // activityIndicator for textfield
    private let activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    private var userModel = UserModel()
    
    //custom activityIndicator
    private let activityIndicatorView = ActivityIndicator()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // добавляємо tap по екрану для скриття клавіатури
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        self.view.addGestureRecognizer(tap)
     
        //настройки для добавляння view справа в textfiled
        username.rightViewMode = .always
        
        //padding In TextFieldView
        let paddingInTextField = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: self.username.frame.height))
        username.leftView = paddingInTextField
        username.leftViewMode = .always
    }
    
    // первіряєм првильність ведення ім'я
    @IBAction func checkUserName(_ sender: UITextField) {
        // добавляєм activityIndicator в textfiled з правої сторони
        self.username.rightView = self.activityIndicator
        self.activityIndicator.startAnimating()
        
        if sender.text!.count >= 3 {
            
            SettingsViewItemCheckUITextField(textField: sender)
            
            nextButton.isEnabled = true
            nextButton.backgroundColor = UIColor.systemGreen
            
            // зупиняєм activity indicator
            self.activityIndicator.stopAnimating()
        }else{
            // міняємо колір бордера на червоний
            SettingsViewItemErrorCheckUITextField(textField: sender)
            
            // зупиняєм activity indicator
            self.activityIndicator.stopAnimating()
        }
    }
    
    // після натискання кнопкипоказується activityIndicator після чого якщо є ім'я користувача, доабляєм його в userModel і переходим в ProfileImageViewController
    @IBAction func NextStepClick(_ sender: UIButton) {
        self.present(self.activityIndicatorView.alert, animated: true, completion: nil)
        if let username = self.username.text{
            self.userModel.username = username
            self.activityIndicatorView.alert.dismiss(animated: true) {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let profilePhotoVC = storyboard.instantiateViewController(withIdentifier: "ProfileImageViewController") as! ProfileImageViewController
                profilePhotoVC.userModel = self.userModel
                profilePhotoVC.modalPresentationStyle = .fullScreen
                self.present(profilePhotoVC, animated: true, completion: nil)
            }
        }
       
    }
    
    
}

extension UserNameViewController{
    // метод налаштувань ui для textFiled при перевірці при правильних ведених даних
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
    // метод налаштувань ui для textFiled при перевірці при не правильних ведених даних
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
