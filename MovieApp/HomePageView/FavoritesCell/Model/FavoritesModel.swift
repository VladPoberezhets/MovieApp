//
//  FavoritesModel.swift
//  MovieApp
//
//  Created by Vlad on 05.10.2020.
//

import Foundation

struct FavoritesModel:Codable{
    var page:Int
    var results:[Result]
    var total_pages:Int
    var total_results:Int
}

//struct Result:Codable{
//    var poster_path:String
//    var adult:Bool
//    var overview:String
//    var release_date:String
//    var genre_ids:[Int]
//    var id:Int
//    var original_title:String
//    var original_language:String
//    var title:String
//    var backdrop_path:String
//    var popularity:Double
//    var vote_count:Double
//    var video:Bool
//    var vote_average:Double
//    var dates:Dates
//
//
//}
//
//struct Dates:Codable{
//    var maximum:String
//    var minimum:String
//}
