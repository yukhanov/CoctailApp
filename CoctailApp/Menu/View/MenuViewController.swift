//
//  MenuViewController.swift
//  CoctailApp
//
//  Created by Сергей Юханов on 03.04.2023.
//

import UIKit

final class MenuViewController: UIViewController {
    
    var presenter: MenuPresenterInput?
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Москва"
        return label
    }()
    
    private let changeCityButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let bannerCollectionView: UICollectionView = {
        var collectionView = UICollectionView()
        let layout = UICollectionViewFlowLayout()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: 300,
                                 height: 115)
        collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setConstraints()
        
    }
    
}

extension MenuViewController {
    func setViews() {
        view.addSubview(cityLabel)
        view.addSubview(changeCityButton)
        view.addSubview(bannerCollectionView)
    }
    
    func setConstraints() {
        
    }
}
