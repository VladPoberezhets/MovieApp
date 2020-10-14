//
//  MoviesModel.swift
//  MovieApp
//
//  Created by Vlad on 13.10.2020.
//

import Foundation

// она модель на всі категорії
struct MoviesModel:Codable{
    var results:[ResultMovies]

}

struct ResultMovies:Codable{
    var poster_path:String
    var adult:Bool
    var overview:String
    var release_date:String
    var genre_ids:[Int]
    var id:Int
    var original_title:String
    var original_language:String
    var title:String
    var backdrop_path:String
    var popularity:Double
    var vote_count:Double
    var video:Bool
    var vote_average:Double
}
