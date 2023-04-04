//
//  MenuVC+Extension.swift
//  CoctailApp
//
//  Created by Сергей Юханов on 03.04.2023.
//

import UIKit

extension MenuViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    

   
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if collectionView === bannerCollectionView {
            return imageArrayForBanner.count
        } else {
            return presenter?.numberOfCategories() ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView === bannerCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: BannerCell.identifier,
                for: indexPath) as? BannerCell else {
                return UICollectionViewCell()
            }
            cell.bannerImageView.image = UIImage(named: imageArrayForBanner[indexPath.row])
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CategoryCell.identifier,
                for: indexPath) as? CategoryCell,
                  let category = presenter?.categoryModel(at: indexPath.row) else {
                return UICollectionViewCell()
            }
            cell.configure(withDrink: category)
            return cell
        }
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfDrinks() ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ListTableViewCell.identifier,
            for: indexPath) as? ListTableViewCell,
              let drink = presenter?.drinkModel(at: indexPath.row) else {
            return UITableViewCell()
        }
        cell.configure(withDrink: drink)
        return cell
    }
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let safeArea = view.safeAreaLayoutGuide
        
        guard scrollView === listTableView else {
            return
        }
        
        if let firstIndex = listTableView.indexPathsForVisibleRows?.first?.row,
           let drink = presenter?.drinkModel(at: firstIndex),
           let category = drink.strCategory,
           let indexOfCategory = presenter?.indexOfCategory(category) {
            
            categoryCollectionView.scrollToItem(
                at: IndexPath(row: indexOfCategory, section: 0),
                at: [.centeredVertically, .centeredHorizontally],
                animated: false
            )
            if let cell = categoryCollectionView.cellForItem(
                at: IndexPath(row: prevIndex, section: 0)
            ) {
                cell.contentView.backgroundColor = .white
                cell.contentView.layer.borderWidth = 1
                (cell as? CategoryCell)!.categoryLabel.textColor = #colorLiteral(red: 1, green: 0.07642265409, blue: 0.2490411103, alpha: 1)
            }
            
            if let cell = categoryCollectionView.cellForItem(
                at: IndexPath(row: indexOfCategory, section: 0)
            ) {
                prevIndex = indexOfCategory
                cell.contentView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
                cell.contentView.layer.borderWidth = 0
                (cell as? CategoryCell)!.categoryLabel.textColor = #colorLiteral(red: 1, green: 0.07642265409, blue: 0.2490411103, alpha: 1)
            }
        }
        
        if scrollView.contentOffset.y >= 100 {
            
            NSLayoutConstraint.activate([
                categoryCollectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
                categoryCollectionView.topAnchor.constraint(equalTo: bannerCollectionView.topAnchor),
                categoryCollectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
                categoryCollectionView.heightAnchor.constraint(equalToConstant: 32)
            ])
      
            
            UIView.animate(withDuration: 0.2, animations: {
                self.bannerCollectionView.isHidden = true
                self.view.layoutIfNeeded()
            })
            
        } else {
            
            NSLayoutConstraint.activate([
                categoryCollectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
                categoryCollectionView.topAnchor.constraint(equalTo: bannerCollectionView.bottomAnchor, constant: 24),
                categoryCollectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
                categoryCollectionView.heightAnchor.constraint(equalToConstant: 32)
            ])
            
            UIView.animate(withDuration: 0.2, animations: {
                self.bannerCollectionView.isHidden = false
                self.view.layoutIfNeeded()
            })
        }
    }
    
}
