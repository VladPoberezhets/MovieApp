//
//  LatestedCollectionViewInCell.swift
//  MovieApp
//
//  Created by Vlad on 05.10.2020.
//

import UIKit

class LatestedCollectionViewInCell: UICollectionViewCell {
    
    private let latestedPresenter = LatestedPresenter(latestedServises: LatestedServises())
    
    // обєкт класа в якому будем визивати метод для отримання картинки
    private let latestedServises = LatestedServises()
    
    // масив з отриманими обєктами
    private var result = [Result]()
    
    //створюєм collectionView
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout();
        layout.scrollDirection = .vertical; //set scroll direction to horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout);
        cv.backgroundColor = UIColor.systemGroupedBackground  //testing
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv;
    }();
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        //підписуємся на делегат
        latestedPresenter.setDelegate(latestedDelegate: self)
        //запускаєм функцію з якої отримуєм дані з апі
        latestedPresenter.SetDataLatestedToUI()
        
        setupViews();
        //руєтруємо кастомну ячєйку
        collectionView.register(LatestedCell.nib(), forCellWithReuseIdentifier: "LatestedCell"); //register custom UICollectionViewCell class.
        
        
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

extension LatestedCollectionViewInCell:LatestedDelegate{
    func GetLatestedData(obj: LatestedModel) {
        self.result = obj.results
        self.collectionView.reloadData()
    }
    
}


extension LatestedCollectionViewInCell:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestedCell", for: indexPath) as! LatestedCell
        
        cell.title.text = result[indexPath.row].title
        cell.date.text = result[indexPath.row].release_date
        cell.descritptionMovie.text = result[indexPath.row].overview
        
        latestedServises.GetImage(urlImage: result[indexPath.row].poster_path) { (image) in
            cell.image.image = image
        }
        
        return cell;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return result.count
    }
    //розмір collectionView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width-10, height: 240);
    }
}
