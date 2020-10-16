//
//  DetailViewController.swift
//  MovieApp
//
//  Created by Vlad on 13.10.2020.
//

import UIKit
import FirebaseDatabase
import Firebase

class DetailViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var descriptionMovie: UITextView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var buttonAddFavorites: UIButton!
    
    private let activityIndicator = UIActivityIndicatorView()
    
    // обєкт даних для відобареження
    var resultMovies:ResultMovies?
    
    //обєкт для визову функції отримання картинки
    private let favoritesMoviePresenter = FavoritesMoviePresenter()
    
    private let userId = Auth.auth().currentUser?.uid
    
    private var checkButtonState = true
    
    private let getImageFromUrl = GetImageFromUrl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.addSubview(activityIndicator)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y-50, width: view.frame.width, height: view.frame.height)
        activityIndicator.style = .medium
        activityIndicator.backgroundColor = .white
        activityIndicator.startAnimating()
        
        
        // отримуєм картинку по url
        if let result = resultMovies{
            getImageFromUrl.GetImage(urlImage: result.poster_path) { (image) in
                self.image.image = image
            }
        }
        
        // check film is added to favorites and edit button style
        if userId != nil{
            if let result = resultMovies{
                favoritesMoviePresenter.CheckDataInDataBase(postId: result.id) { (resultCheck) in
                    if resultCheck == true{
                        
                        self.buttonAddFavorites.setTitle("Delete from favorites", for: .normal)
                        self.buttonAddFavorites.setTitleColor(.red, for: .normal)
                        self.buttonAddFavorites.setImage(UIImage(systemName: "trash"), for: .normal)
                        
                        self.buttonAddFavorites.tintColor = .red
                        
                        self.checkButtonState = true
                        
                        self.activityIndicator.stopAnimating()
                    }else{
                        self.checkButtonState = false
                        self.activityIndicator.stopAnimating()
                    }
                }
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
    
    // add data to data base
    @IBAction func AddToFavorites(_ sender: UIButton) {
        
        self.activityIndicator.startAnimating()
        
        print(self.checkButtonState)
        
        // add data from data base
        if self.checkButtonState == true{
                if let result = resultMovies{
                    favoritesMoviePresenter.AddDataToDataBase(resultMovies: result) { (result) in
                        if result == true{
                            self.buttonAddFavorites.setTitle("Delete from favorites", for: .normal)
                            self.buttonAddFavorites.setTitleColor(.red, for: .normal)
                            self.buttonAddFavorites.setImage(UIImage(systemName: "trash"), for: .normal)
                            self.buttonAddFavorites.tintColor = .red
                            
                            self.checkButtonState = false
                            
                            self.activityIndicator.stopAnimating()
                        }else{
                            self.activityIndicator.stopAnimating()
                            
                            let alert = UIAlertController(title: "Error", message: "Please try again", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
            }
        }else{
            // remove data from data base
            if let result = resultMovies{
                self.favoritesMoviePresenter.RemoveDataFromDataBase(postId: result.id) { (resultDelete) in
                    if resultDelete == true{
                        self.buttonAddFavorites.setTitle("Add to favorites", for: .normal)
                        self.buttonAddFavorites.setImage(UIImage(systemName: "star.circle.fill"), for: .normal)
                        self.buttonAddFavorites.setTitleColor(UIColor.systemOrange, for: .normal)
                        self.buttonAddFavorites.tintColor = UIColor.systemOrange
                        
                        self.checkButtonState = true
                        self.activityIndicator.stopAnimating()
                    }else{
                        self.activityIndicator.stopAnimating()
                        
                        let alert = UIAlertController(title: "Error", message: "Please try again", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
}
