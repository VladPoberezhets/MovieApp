//
//  PopularDelegate.swift
//  MovieApp
//
//  Created by Vlad on 12.10.2020.
//

import Foundation
// делегат через який передаєм дані в viewController
protocol PopularDelegate{
    func GetLatestedData(obj:PopularModel)
}
