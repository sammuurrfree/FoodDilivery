//
//  CollectionViewViewController.swift
//  FoodDilivery
//
//  Created by Преподаватель on 02.12.2021.
//

import UIKit

class CollectionViewViewController: UIViewController {

    var int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    

}


extension CollectionViewViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 235
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        
        cell.contentView.backgroundColor = indexPath.item % 4 == 1 || indexPath.item % 4 == 2 ? #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1) : #colorLiteral(red: 0.9225539565, green: 0.9225539565, blue: 0.9225539565, alpha: 1) 
        if indexPath.row == 0{
            cell.contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return indexPath.item % 4 == 1 || indexPath.item % 4 == 2 ? CGSize(width: 160, height: 255) : CGSize(width: 160, height: 280)
    }
}
