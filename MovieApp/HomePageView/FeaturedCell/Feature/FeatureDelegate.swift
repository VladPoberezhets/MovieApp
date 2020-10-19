//
//  FeatureDelegate.swift
//  MovieApp
//
//  Created by Vlad on 06.10.2020.
//

import Foundation
import UIKit

// делегат через який передаєм дані в viewController
protocol FeatureDelegate{
    func GetFeatureData(obj:MoviesModel)
}
