//
//  FavoritesCell.swift
//  MovieApp
//
//  Created by Vlad on 02.10.2020.
//

import UIKit

class FavoritesCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    

    static func nib()->UINib{
        
        return UINib(nibName: "FavoritesCell", bundle: nil)
    }
    
    
  
    
  
    
}
