//
//  DetailViewController.swift
//  MovieApp
//
//  Created by Vlad on 13.10.2020.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var descriptionMovie: UITextView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var buttonAddFavorites: UIButton!
    
    // обєкт даних для відобареження
    var resultMovies:ResultMovies?
    
    //обєкт для визову функції отримання картинки
    private let popularServises = PopularServises()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // отримуєм картинку по url
        if let result = resultMovies{
            popularServises.GetImage(urlImage: result.poster_path) { (image) in
                self.image.image = image
            }
        }
        
        SetDataToUI()

    }
    
    // добавляєм дані в ui елементи
    func SetDataToUI(){
        titleMovie.text = resultMovies?.title
        descriptionMovie.text = resultMovies?.overview
        date.text = resultMovies?.release_date
        
    }
    
    
    @IBAction func AddToFavorites(_ sender: UIButton) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
