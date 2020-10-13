//
//  LatestedDelegate.swift
//  MovieApp
//
//  Created by Vlad on 06.10.2020.
//

import Foundation

// делегат через який передаєм дані в viewController
protocol LatestedDelegate{
    func GetLatestedData(obj:LatestedModel)
}
