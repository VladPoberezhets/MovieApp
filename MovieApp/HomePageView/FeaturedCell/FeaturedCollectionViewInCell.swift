//
//  FeaturedCollectionViewInCell.swift
//  MovieApp
//
//  Created by Vlad on 05.10.2020.
//

import UIKit

class FeaturedCollectionViewInCell: UICollectionViewCell{
    
    private let featurePresenter = FeaturePresenter(featureServises: FeatureServises())
    
    // обєкт класа в якому будем визивати метод для отримання картинки
    private let featureServises = FeatureServises()
    
    // масив з отриманими обєктами
    private var result = [ResultMovies]()
    
    private let getImageFromUrl = GetImageFromUrl()
    
    //створюєм collectionView
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout();
        layout.scrollDirection = .horizontal; //set scroll direction to horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout);
        cv.backgroundColor = UIColor.systemGroupedBackground //testing
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv;
    }();
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        //підписуємся на делегат
        featurePresenter.setDelegate(featureDelegate: self)
        //запускаєм функцію з якої отримуєм дані з апі
        featurePresenter.SetDataFeatureToUI()
        
        
        setupViews();
        //руєтруємо кастомну ячєйку
        collectionView.register(FeaturedCell.nib(), forCellWithReuseIdentifier: "FeaturedCell"); //register custom UICollectionViewCell class.
        
    }
    
    
    func setupViews(){
        //добавляєм collectionView в ячєйку
        addSubview(collectionView);
        
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true;
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true;
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true;
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension FeaturedCollectionViewInCell:FeatureDelegate{
    func GetFeatureData(obj: MoviesModel) {
        self.result = obj.results
        self.collectionView.reloadData()
    }
    
    func GetFeatureImage(image: UIImage) {
        print("image")
    }
    
}

extension FeaturedCollectionViewInCell:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCell", for: indexPath) as! FeaturedCell
        
        cell.title.text = result[indexPath.row].title
        cell.date.text = result[indexPath.row].release_date
        cell.rating.text = "\(result[indexPath.row].vote_average)"
        
        // знаходи іприсваєюм картинку в ячейку
        getImageFromUrl.GetImage(urlImage: result[indexPath.row].poster_path) { (image) in
            cell.image.image = image
        }
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.result.count
    }
    //розмір collectionView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: self.frame.height - 10);
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let stroryboard = UIStoryboard(name: "Detail", bundle: nil)
        let detailVC = stroryboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.resultMovies = result[indexPath.row]
//        detailVC.modalPresentationStyle = .fullScreen
        self.window?.rootViewController?.present(detailVC, animated: true, completion: nil)
    
    }
}
