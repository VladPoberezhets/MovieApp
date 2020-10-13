//
//  HeaderCollectionReusableView.swift
//  MovieApp
//
//  Created by Vlad on 06.10.2020.
//

import UIKit

class FeatureHeaderCollectionReusableView: UICollectionReusableView {
      static  let identifire = "HeaderCollectionReusableView"
    
    private let label:UILabel = {
        let label = UILabel()
        label.text = "Featured"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        
        label.textColor = .black
        return label
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
        label.frame = bounds
    }
}
