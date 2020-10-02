//
//  ProfileTableViewCell.swift
//  MovieApp
//
//  Created by Vlad on 30.09.2020.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    //картинка користувача
    @IBOutlet  var imageForLabel: UIImageView!
    //ім'я користувача
    @IBOutlet  var label: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // метод для отримання UI з nib файлу
    static func nib()->UINib{
        return UINib(nibName: "ProfileTableViewCell", bundle: nil)
    }

}
