//
//  MenuVC+Extension.swift
//  CoctailApp
//
//  Created by Сергей Юханов on 03.04.2023.
//

import UIKit

extension MenuViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView === bannerCollectionView {
            return 5
        } else {
            return presenter?.numberOfCategories() ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView === bannerCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BannerCell.identifier,
                for: indexPath) as? BannerCell else {
                return UICollectionViewCell()
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryCell.identifier,
                for: indexPath) as? CategoryCell,
                  let category = presenter?.getCategory(at: indexPath.row) else {
                return UICollectionViewCell()
            }
            cell.configure(withDrink: category)
            return cell
        }
    }
    

    
}
