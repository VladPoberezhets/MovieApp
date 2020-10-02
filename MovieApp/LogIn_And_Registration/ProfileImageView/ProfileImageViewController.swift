//
//  ProfileImageViewController.swift
//  MovieApp
//
//  Created by Vlad on 30.09.2020.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class ProfileImageViewController: UIViewController {
    
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    
    private var imagePicker: ImagePicker!
    // об'єк в якому знаходяться методи для зберігання даних в бд i Storage firabase
    private var profileImageSettings = ProfileImageSettings()
    
    // custom activityIndicator
    private let activityIndicator = ActivityIndicator()
    
    var userModel:UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //підписуємся під делегат ImagePickerDelegate
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    //після натискання кнопки з'являється вікно галереї
    @IBAction func EnterProfileImageButton(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    //після натискання на кнопку з'являється activityIndicator, перевіряєть чи є модель користувача не пустою, якщо є дані викликаються методи setUsersPhoto(для зберігання фотки в Storage firabase) i addUserInfoToDataBase(для занесення даних в базу даних firabase), після цього переходимо до ProfileViewController
    @IBAction func finishButtonClick(_ sender: UIButton) {
        self.present(self.activityIndicator.alert, animated: true, completion: nil)
        if let userModel = self.userModel{
            profileImageSettings.setUsersPhoto(withImage: userModel.profileImage)
            profileImageSettings.addUserInfoToDataBase(userModel: userModel)
        }
        self.activityIndicator.alert.dismiss(animated: true) {
            let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
            let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileViewController")
            profileVC.modalPresentationStyle = .fullScreen
            self.present(profileVC, animated: true, completion: nil)
        }
    }
    
}

extension ProfileImageViewController: ImagePickerDelegate {
    //метод протоколу ImagePickerDelegate для передачі даних в userModel
    func didSelect(image: UIImage?) {
        if let image = image{
            self.profileImage.image = image
            
            finishButton.isEnabled = true
            finishButton.backgroundColor = UIColor.systemGreen
            
            self.userModel?.profileImage = image
        }
    }
    
}
