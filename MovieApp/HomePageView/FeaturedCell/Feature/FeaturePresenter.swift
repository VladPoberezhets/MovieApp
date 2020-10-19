//
//  FeatureProvider.swift
//  MovieApp
//
//  Created by Vlad on 06.10.2020.
//

import Foundation

class FeaturePresenter{
    private var featureDelegate:FeatureDelegate?
    private let featureServises:FeatureServises
    
    init(featureServises:FeatureServises) {
        self.featureServises = featureServises
    }
    // функция через яку ми підписуємся на делегат
    func setDelegate(featureDelegate:FeatureDelegate){
            self.featureDelegate = featureDelegate
        }
    // функція через яку ми передаєм делегату дані
    func SetDataFeatureToUI(){
        featureServises.GetDataFeature { (featureModel) in
            self.featureDelegate!.GetFeatureData(obj: featureModel)
        }
    }
    
 
}
