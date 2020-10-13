//
//  PopularCollectionViewCell.swift
//  MovieApp
//
//  Created by Vlad on 12.10.2020.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.image.image = nil
    }
    
    static func nib()->UINib{
        return UINib(nibName: "PopularCell", bundle: nil)
    }
}
