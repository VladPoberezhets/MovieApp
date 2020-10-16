//
//  GetImageFromUrl.swift
//  MovieApp
//
//  Created by Vlad on 16.10.2020.
//

import Foundation
import AlamofireImage
import UIKit
import Alamofire

struct GetImageFromUrl{
    /**
    This function returns a UIImage.
     
    **Parameters:**
        - complition: return clouser UIImage.
     - urlImage: path url image.
    */
    func GetImage(urlImage:String, complition:@escaping (UIImage)->Void){
        let url = "https://image.tmdb.org/t/p/original"
        DispatchQueue.global(qos: .userInteractive).async {
            AF.request(url+urlImage).responseImage { (image) in
                if let image = image.value{
                    complition(image)
                }else{
                    print("error request image")
                }
            }
        }
    }
}
