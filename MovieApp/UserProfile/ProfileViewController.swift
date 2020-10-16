//
//  ProfileViewController.swift
//  MovieApp
//
//  Created by Vlad on 30.09.2020.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import Firebase

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var tableViewSettings: UITableView!
    
    // клас з методами для отримання картинки і ім'я користувача
    private var profileSettings:ProfileSettings?
    
    // обявляємклас з кастом alert з activityIndicator
    private let activityIndicatorView = ActivityIndicator()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewSettings.delegate = self
        tableViewSettings.dataSource = self
        tableViewSettings.sectionHeaderHeight = 0.0
        tableViewSettings.separatorStyle = .none
        
        // приєднуєм ячєйку з nib файла
        tableViewSettings.register(ProfileTableViewCell.nib(), forCellReuseIdentifier: "ProfileCell")
        
            // показуєм alert з activityIndicator
        self.present(self.activityIndicatorView.alert, animated: true, completion: nil)
        
        // підписуємся під делегат ProfileDelegate
        profileSettings = ProfileSettings(delegate: self)
        
        // визиваєм метод для отримання картинки
        profileSettings?.getImage()
        // визиваєм метод для отримання ім'я користувача
        profileSettings?.getUserName()

    }

}

extension ProfileViewController:ProfileDelegate{
    //метод делегата ProfileDelegate для отрмання картинки
    func GetImage(image: UIImage) {
        self.profileImage.image = image
    }
    
    //метод делегата ProfileDelegate для отрмання ім'я користувача
    func GetName(name: String) {
        self.username.text = name
        // скриваєм activityIndcator
        self.activityIndicatorView.alert.dismiss(animated: true, completion: nil)
    }
    
    
}


extension ProfileViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return ProfileSettings.SettingsItem.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell") as! ProfileTableViewCell
       
        //для кожної окремий контент
        if indexPath.section == 0{
            cell.label.text = ProfileSettings.SettingsItem.Favorites.rawValue
            cell.imageView?.image = UIImage(named: "Favorites")
        }else if indexPath.section == 1{
            cell.label.text = ProfileSettings.SettingsItem.AboutUs.rawValue
            cell.imageView?.image = UIImage(named:"AboutUs")
        }else if indexPath.section == 2{
            cell.label.text = ProfileSettings.SettingsItem.Settings.rawValue
            cell.imageView?.image = UIImage(named:"Settings")
        }else if indexPath.section == 3{
            cell.label.text = ProfileSettings.SettingsItem.Exit.rawValue
            cell.imageView?.image = UIImage(named:"exit")
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // exit user
        if indexPath.section == 3{
            do{
               try Auth.auth().signOut()
                if Auth.auth().currentUser?.uid == nil{
                    let sb = UIStoryboard(name: "Main", bundle: nil)
                    let vc = sb.instantiateViewController(withIdentifier: "NavigationViewController")
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
            }catch{
                print("error sing out")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 10 //expected minimum height of the cell
    }
    // height cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
