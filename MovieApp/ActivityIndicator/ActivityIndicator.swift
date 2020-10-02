//
//  ActivityIndicator.swift
//  MovieApp
//
//  Created by Vlad on 01.10.2020.
//

import Foundation
import UIKit

// кастомний ActivityIndicator
class ActivityIndicator{
     let activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
     let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
    
    init() {
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.color = .gray
        self.activityIndicator.startAnimating()
        alert.view.addSubview(activityIndicator)
    }
    
}
