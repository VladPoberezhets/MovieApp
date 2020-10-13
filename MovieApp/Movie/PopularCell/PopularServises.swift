//
//  PopularSettings.swift
//  MovieApp
//
//  Created by Vlad on 12.10.2020.
//

import Foundation
import Alamofire

class PopularServises{
    
    /**
    This function returns a PopularModel.
     
    **Parameters:**
        - complition: return clouser PopularModel object.
    */
    func GetDataPapular(complition:@escaping (PopularModel)->Void){
        let url = "https://api.themoviedb.org/3/movie/popular?"
        let api_key = "f910e2224b142497cc05444043cc8aa4"
        let language = "en-US"
        let page = "1"
        
        DispatchQueue.global(qos: .userInteractive).async {
            AF.request("\(url)api_key=\(api_key)&language=\(language)&page=\(page)").response { (response) in
                if let data = response.data{
                    let jsonDecoder = JSONDecoder()
                    let popularData = try! jsonDecoder.decode(PopularModel.self, from: data)
                    complition(popularData)
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
