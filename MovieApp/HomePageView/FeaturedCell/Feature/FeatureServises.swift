//
//  FeatureServises.swift
//  MovieApp
//
//  Created by Vlad on 06.10.2020.
//

import Foundation
import Alamofire
import AlamofireImage

class FeatureServises{
    
    /**
    This function returns a FeatureModel.
     
    **Parameters:**
        - complition: return clouser FeatureModel object.
    */
    func GetDataFeature(complition:@escaping (MoviesModel)->Void){
        let url = "https://api.themoviedb.org/3/movie/upcoming?"
        let api_key = "f910e2224b142497cc05444043cc8aa4"
        let language = "en-US"
        let page = "1"
        
        DispatchQueue.global(qos: .userInteractive).async {
            AF.request("\(url)api_key=\(api_key)&language=\(language)&page=\(page)").response { (response) in
                if let data = response.data{
                    let jsonDecoder = JSONDecoder()
                    let featureData = try! jsonDecoder.decode(MoviesModel.self, from: data)
                    complition(featureData)
                }else{
                    print("Erorr request")
                }
            }
        }
        
    }
    
    /**
    This function returns a UIImage.
     
    **Parameters:**
        - complition: return clouser UIImage.
     - urlImage: path url image.
    */
    func GetImage(urlImage:String, complition:@escaping (UIImage)->Void){
        let url = "https://image.tmdb.org/t/p/original"
        DispatchQueue.main.async {
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