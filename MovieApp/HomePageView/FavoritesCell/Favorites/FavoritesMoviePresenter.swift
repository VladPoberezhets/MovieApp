//
//  MoviePresenter.swift
//  MovieApp
//
//  Created by Vlad on 15.10.2020.
//

import Foundation
import AlamofireImage
import Alamofire
import Firebase
import FirebaseDatabase
import CodableFirebase

class FavoritesMoviePresenter{
    private let dataBase = Database.database().reference()
    private let userId = Auth.auth().currentUser?.uid
    
    private var favoritesDelegate:FavoritesDelegate?
    
    // функция через яку ми підписуємся на делегат
    func setDelegate(favoritesDelegate:FavoritesDelegate){
            self.favoritesDelegate = favoritesDelegate
        }
    
    // added data ro firebase data base
    func AddDataToDataBase(resultMovies:ResultMovies?, complition:@escaping (Bool)->Void){
        
        
        DispatchQueue.main.async {
            if let userId = self.userId{
                if let result = resultMovies{
                    self.dataBase.child("\(userId)").child("favorites").child("\(result.id)").setValue([
                        "poster_path":result.poster_path,
                        "adult":result.adult,
                        "overview":result.overview,
                        "release_date":result.release_date,
                        "genre_ids":result.genre_ids,
                        "id":result.id,
                        "original_title":result.original_title,
                        "original_language":result.original_language,
                        "title":result.title,
                        "backdrop_path":result.backdrop_path,
                        "popularity":result.popularity,
                        "vote_count":result.vote_count,
                        "video":result.video,
                        "vote_average":result.vote_average
                    ])
                }else{
                    print("error add data to database")
                }
                
                self.CheckDataInDataBase(postId: resultMovies?.id ?? 0, complitionCheck: { (result) in
                    complition(result)
                })
                
            }else{
                print("error don't came user id")
            }
            
        }
        
    }
    
    // checking fovorites data in firabse data base
    func CheckDataInDataBase(postId:Int, complitionCheck:@escaping (Bool)->Void){
        DispatchQueue.global(qos: .userInteractive).async {
            self.dataBase.child("\(self.userId ?? "")").child("favorites").observeSingleEvent(of: .value) { (response) in
                if response.hasChild("\(postId)"){
                    complitionCheck(true)
                }else{
                    complitionCheck(false)
                }
            }
        }
    }
    
    // delete favorites data from firebase
    func RemoveDataFromDataBase(postId:Int, complition:@escaping (Bool)->Void){
        DispatchQueue.main.async {
            if let userId = self.userId{
                self.dataBase.child("\(userId)").child("favorites").child("\(postId)").removeValue { (error,obj)  in
                    if error == nil{
                        complition(true)
                    }else{
                        complition(false)
                    }
                }
            }
        }
    }
    
    // get data favorites from firebase
    func GetDataFromDataBase(){
        self.dataBase.child("\(userId!)").child("favorites").observe(.value) { (response) in
            if let data = response.value as? [String:Any] {
                do{
                    let results = try FirebaseDecoder().decode([ResultMovies].self, from: data.values.map{$0})
                    self.favoritesDelegate!.GetFavoritesData(arr:results)
                }catch let error{
                    print(error)
                }
                
//                complition(data.values.map{$0})
            }else{
                print("erorr get data favorites")
            }
        }
    }
    
}
