//
//  FeaturedCell.swift
//  MovieApp
//
//  Created by Vlad on 02.10.2020.
//

import UIKit

class FeaturedCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.image.image = nil
    }
    
    static func nib()->UINib{
        return UINib(nibName: "FeaturedCell", bundle: nil)
    }
}
