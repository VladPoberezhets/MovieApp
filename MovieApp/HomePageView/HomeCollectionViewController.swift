//
//  HomeCollectionViewController.swift
//  MovieApp
//
//  Created by Vlad on 02.10.2020.
//

import UIKit

private let reuseIdentifier = "Cell"

class HomeCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
   
    let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        self.collectionView.addSubview(activityIndicator)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y-50, width: view.frame.width, height: view.frame.height)
        activityIndicator.style = .medium
        activityIndicator.backgroundColor = .white
        activityIndicator.startAnimating()
    
        // реєструєм collectionView з ячєйкою FavoritesCell в ячєйкі HomeCollectionViewController
        collectionView.register(FavoritesCollectionViewInCell.self, forCellWithReuseIdentifier: "FavoritesCell")
        collectionView.register(FeaturedCollectionViewInCell.self, forCellWithReuseIdentifier: "FeaturedCell")
        collectionView.register(LatestedCollectionViewInCell.self, forCellWithReuseIdentifier: "LatestedCell")
        
        // реєстрація Header в Collection
        collectionView.register(FeatureHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FeatureHeaderCollectionReusableView.identifire)
        
        // реєстрація Header в Collection
        collectionView.register(LatestedHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: LatestedHeaderCollectionReusableView.identifire)
        
        // реєстрація Header в Collection
        collectionView.register(FavoritesHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FavoritesHeaderCollectionReusableView.identifire)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            self.activityIndicator.stopAnimating()
        }
    }

    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
        
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoritesCell", for: indexPath) as! FavoritesCollectionViewInCell
            
            return cell
        }else if indexPath.section == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCell", for: indexPath) as! FeaturedCollectionViewInCell
            
            return cell
            
        }else if indexPath.section == 2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestedCell", for: indexPath) as! LatestedCollectionViewInCell
            
            return cell
        }
        
        
        return cell
    }
    
    
    
    //size of each CollecionViewCell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 1{
            return CGSize(width: view.frame.width-20, height: 340);
        }
        if indexPath.section == 2{
            return CGSize(width: view.frame.width-20, height: view.frame.height);
        }
        
        // тут буде перевірки чи є обрані фільми якщо немає то встановлюєм занчення 0 0
        return CGSize(width: view.frame.width-20, height: 200);
    }
    
    
    // настройка секції header
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 1{
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FeatureHeaderCollectionReusableView.identifire, for: indexPath) as! FeatureHeaderCollectionReusableView
            
            header.frame = CGRect(x: 10, y: header.frame.origin.y, width: self.view.frame.width, height: 45)
            
            return header
        }else if indexPath.section == 2{
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: LatestedHeaderCollectionReusableView.identifire, for: indexPath) as! LatestedHeaderCollectionReusableView
            
            header.frame = CGRect(x: 10, y: header.frame.origin.y, width: self.view.frame.width, height: 45)
            
            return header
        }else{
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FavoritesHeaderCollectionReusableView.identifire, for: indexPath) as! FavoritesHeaderCollectionReusableView
            
            header.frame = CGRect(x: 10, y: 0, width: self.view.frame.width, height: 45)
            
            return header
        }
        return UICollectionReusableView()
    }
    
    // розмір header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 45)
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}
