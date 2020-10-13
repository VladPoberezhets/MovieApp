//
//  PopularPresenter.swift
//  MovieApp
//
//  Created by Vlad on 12.10.2020.
//

import Foundation

class PopularPresenter{
    private var popularDelegate:PopularDelegate?
    private let popularServises:PopularServises
    
    init(popularServises:PopularServises) {
        self.popularServises = popularServises
    }
    // функция через яку ми підписуємся на делегат
    func setDelegate(popularDelegate:PopularDelegate){
            self.popularDelegate = popularDelegate
        }
    // функція через яку ми передаєм делегату дані
    func SetDataPopularToUI(){
        popularServises.GetDataPapular { (popularModel) in
            self.popularDelegate!.GetLatestedData(obj: popularModel)
        }
    }
}
