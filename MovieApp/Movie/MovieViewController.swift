//
//  MovieViewController.swift
//  MovieApp
//
//  Created by Vlad on 11.10.2020.
//

import UIKit
import AlamofireImage

class MovieViewController: UIViewController {
    
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
        didSet{
            interfaceSegmented.setButtonTitles(buttonTitles: ["Featured","Latested","Popular","Favorites"])
            interfaceSegmented.selectorViewColor = .orange
            interfaceSegmented.selectorTextColor = .orange
        }
    }
    
    private let activityIndicator = UIActivityIndicatorView()
    
    private var index:Int = 0
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let featurePresenter = FeaturePresenter(featureServises: FeatureServises())
    
    // обєкт класа в якому будем визивати метод для отримання картинки
    private let featureServises = FeatureServises()
    
    // масив з отриманими обєктами
    private var result = [ResultMovies]()
    
    
    private let latestedPresenter = LatestedPresenter(latestedServises: LatestedServises())
    
    // обєкт класа в якому будем визивати метод для отримання картинки
    private let latestedServises = LatestedServises()
    
    // масив з отриманими обєктами
    private var resultLatested = [ResultMovies]()
    
    private let popularPresenter = PopularPresenter(popularServises: PopularServises())
    
    // обєкт класа в якому будем визивати метод для отримання картинки
    private let popularServises = PopularServises()
    
    // масив з отриманими обєктами
    private var resultPopular = [ResultMovies]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.collectionView.addSubview(activityIndicator)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y-150, width: view.frame.width, height: view.frame.height)
        activityIndicator.style = .medium
        activityIndicator.backgroundColor = .white
        activityIndicator.startAnimating()
        
        
        interfaceSegmented.setDelegate(delegate: self)
        
        // реєструєм collectionView з ячєйкою FavoritesCell в ячєйкі HomeCollectionViewController
        collectionView.register(FavoritesCell.nib(), forCellWithReuseIdentifier: "FavoritesCell")
        collectionView.register(FeaturedCell.nib(), forCellWithReuseIdentifier: "FeaturedCell")
        collectionView.register(LatestedCell.nib(), forCellWithReuseIdentifier: "LatestedCell")
        collectionView.register(PopularCollectionViewCell.nib(), forCellWithReuseIdentifier: "PopularCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        //підписуємся на делегат
        featurePresenter.setDelegate(featureDelegate: self)
        //запускаєм функцію з якої отримуєм дані з апі
        featurePresenter.SetDataFeatureToUI()
        
        //підписуємся на делегат
        latestedPresenter.setDelegate(latestedDelegate: self)
        //запускаєм функцію з якої отримуєм дані з апі
        latestedPresenter.SetDataLatestedToUI()
        
        //підписуємся на делегат
        popularPresenter.setDelegate(popularDelegate: self)
        //запускаєм функцію з якої отримуєм дані з апі
        popularPresenter.SetDataPopularToUI()
        
        print(interfaceSegmented.selectedIndex)
    }
    
}

extension MovieViewController:CustomSegmentedControlDelegate{
    //get index custom segment controll
    func change(to index: Int) {
        self.index = index
        collectionView.reloadData()
        print(self.index)
    }
    
    
}

extension MovieViewController:FeatureDelegate{
    func GetFeatureData(obj: MoviesModel) {
        self.result = obj.results
        if !resultPopular.isEmpty && !resultLatested.isEmpty && !result.isEmpty{
            activityIndicator.stopAnimating()
            self.collectionView.reloadData()
        }
    }
    
    func GetFeatureImage(image: UIImage) {
        print("image")
    }
}

extension MovieViewController:LatestedDelegate{
    //latested data
    func GetLatestedData(obj: MoviesModel) {
        self.resultLatested = obj.results
        if !resultPopular.isEmpty && !resultLatested.isEmpty && !result.isEmpty{
            activityIndicator.stopAnimating()
            self.collectionView.reloadData()
        }
    }
}

extension MovieViewController:PopularDelegate{
    func GetPopularData(obj: MoviesModel) {
        self.resultPopular = obj.results
        if !resultPopular.isEmpty && !resultLatested.isEmpty && !result.isEmpty{
            activityIndicator.stopAnimating()
            self.collectionView.reloadData()
        }
    }
}

extension MovieViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.result.count
    }
    
    // відображення даних в ячєйкі
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "defaultCell", for: indexPath)
        if index == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCell", for: indexPath) as! FeaturedCell
            
            cell.title.text = result[indexPath.row].title
            cell.date.text = result[indexPath.row].release_date
            cell.rating.text = "\(result[indexPath.row].vote_average)"
            
            // знаходи іприсваєюм картинку в ячейку
            featureServises.GetImage(urlImage: result[indexPath.row].poster_path) { (image) in
                cell.image.image = image
            }
            
            return cell
        }else if index == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestedCell", for: indexPath) as! LatestedCell
            
            cell.title.text = resultLatested[indexPath.row].title
            cell.date.text = resultLatested[indexPath.row].release_date
            cell.descritptionMovie.text = resultLatested[indexPath.row].overview
            
            latestedServises.GetImage(urlImage: resultLatested[indexPath.row].poster_path) { (image) in
                cell.image.image = image
            }
            return cell
        }else if index == 2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCell", for: indexPath) as! PopularCollectionViewCell
            
            cell.title.text = resultPopular[indexPath.row].title
            cell.date.text = resultPopular[indexPath.row].release_date
            cell.rating.text = "\(resultPopular[indexPath.row].vote_average)"
            
            // знаходи іприсваєюм картинку в ячейку
            popularServises.GetImage(urlImage: resultPopular[indexPath.row].poster_path) { (image) in
                cell.image.image = image
            }
            return cell
        }
        return cell
    }
    
    //size of each CollecionViewCell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if index == 0{
            return CGSize(width: view.frame.width-20, height: 340);
        }
        if index == 1{
            return CGSize(width: view.frame.width-20, height: 240);
        }
        if index == 2{
            return CGSize(width: view.frame.width-20, height: 340);
        }
        
        // тут буде перевірки чи є обрані фільми якщо немає то встановлюєм занчення 0 0
        return CGSize(width: view.frame.width-20, height: 200);
    }
    
    // при натисканіна ячєйку переходим до детального перегляду
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let stroryboard = UIStoryboard(name: "Detail", bundle: nil)
        let detailVC = stroryboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        if index == 0 {
            detailVC.resultMovies = result[indexPath.row]
            //        detailVC.modalPresentationStyle = .fullScreen
            self.present(detailVC, animated: true, completion: nil)
        }else if index == 1{
            detailVC.resultMovies = resultLatested[indexPath.row]
            //        detailVC.modalPresentationStyle = .fullScreen
            self.present(detailVC, animated: true, completion: nil)
        }else if index == 2{
            detailVC.resultMovies = resultPopular[indexPath.row]
            //        detailVC.modalPresentationStyle = .fullScreen
            self.present(detailVC, animated: true, completion: nil)
        }
    }
}
