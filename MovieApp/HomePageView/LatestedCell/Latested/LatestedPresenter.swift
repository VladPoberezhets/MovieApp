//
//  LatestedPresenter.swift
//  MovieApp
//
//  Created by Vlad on 06.10.2020.
//

import Foundation

class LatestedPresenter{
    private var latestedDelegate:LatestedDelegate?
    private let latestedServises:LatestedServises
    
    init(latestedServises:LatestedServises) {
        self.latestedServises = latestedServises
    }
    // функция через яку ми підписуємся на делегат
    func setDelegate(latestedDelegate:LatestedDelegate){
            self.latestedDelegate = latestedDelegate
        }
    // функція через яку ми передаєм делегату дані
    func SetDataLatestedToUI(){
        latestedServises.GetDataFeature { (latestedModel) in
            self.latestedDelegate!.GetLatestedData(obj: latestedModel)
        }
    }
    
 
}
