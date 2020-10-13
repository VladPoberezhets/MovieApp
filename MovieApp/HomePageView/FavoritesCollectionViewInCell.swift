//
//  FavoritesCollectionViewInCell.swift
//  MovieApp
//
//  Created by Vlad on 02.10.2020.
//

import UIKit

//colectionView в FavoritesCollectionViewInCell
class FavoritesCollectionViewInCell: UICollectionViewCell {
    
    var isHidde = true
    
    let arr = ["1","2","3","4"]
    
    //створюєм collectionView
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout();
        layout.scrollDirection = .horizontal; //set scroll direction to horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout);
        cv.backgroundColor = .blue; //testing
        cv.translatesAutoresizingMaskIntoConstraints = false;
        return cv;
    }();
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        setupViews();
        //руєтруємо кастомну ячєйку
        collectionView.register(FavoritesCell.nib(), forCellWithReuseIdentifier: "FavoritesCell"); //register custom UICollectionViewCell class.
    }
    
    func setupViews(){
        //добавляєм collectionView в ячєйку
        addSubview(collectionView);
        //            collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
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

extension FavoritesCollectionViewInCell:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritesCell", for: indexPath) as! FavoritesCell
        cell.backgroundColor = .red;
        cell.title.text = arr[indexPath.row]
        cell.date.text = arr[indexPath.row]
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    //розмір collectionView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width-10, height: self.frame.height - 10);
    }
}
