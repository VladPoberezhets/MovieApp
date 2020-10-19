//
//  FavoritesCollectionViewController.swift
//  MovieApp
//
//  Created by Vlad on 19.10.2020.
//

import UIKit
import Firebase


class FavoritesCollectionViewController: UICollectionViewController {

    private let favoritesMoviePresenter = FavoritesMoviePresenter()
    
    var resultMovies = [ResultMovies]()
    
    
    private let getImageFromUrl = GetImageFromUrl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        favoritesMoviePresenter.setDelegate(favoritesDelegate: self)
        favoritesMoviePresenter.GetDataFromDataBase()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(FavoritesCell.nib(), forCellWithReuseIdentifier: "FavoritesCell")

        // Do any additional setup after loading the view.
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return resultMovies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritesCell", for: indexPath) as! FavoritesCell
        
        cell.title.text = resultMovies[indexPath.row].title
        cell.date.text = resultMovies[indexPath.row].release_date
        
        // знаходи іприсваєюм картинку в ячейку
        getImageFromUrl.GetImage(urlImage: resultMovies[indexPath.row].poster_path) { (image) in
            cell.image.image = image
        }
        
        return cell;
    }
    
    //розмір collectionView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width-20, height: 250);
    }
}

extension FavoritesCollectionViewController:FavoritesDelegate{
    func GetFavoritesData(arr: [ResultMovies]) {
        self.resultMovies = arr
        self.collectionView.reloadData()
    }
    
    
}
