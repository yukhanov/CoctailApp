//
//  MenuViewController.swift
//  CoctailApp
//
//  Created by Сергей Юханов on 03.04.2023.
//

import UIKit

final class MenuViewController: UIViewController {
    
    var presenter: MenuPresenterInput?
    var prevIndex = 0
    
    let spinner = UIActivityIndicatorView(style: .large)
    
    let listTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
        return tableView
    }()
    
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
    
    let bannerCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: 300,
                                 height: 115)
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.identifier)
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: 88,
                                 height: 32)
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)

        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callPresenter()
        setViews()
        spinner.center = self.view.center
        spinner.hidesWhenStopped = true
        spinner.color = UIColor.red
        bannerCollectionView.translatesAutoresizingMaskIntoConstraints = false
        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
        configureLists()
        setConstraints()
        
        
       
        
    }
    private func callPresenter() {
        presenter?.getData(for: categoryCollectionView, tableView: listTableView, spinner: spinner)
        presenter?.getImage()
    }
    
}

extension MenuViewController {
    func setViews() {
        view.addSubview(cityLabel)
        view.addSubview(changeCityButton)
        view.addSubview(bannerCollectionView)
        view.addSubview(categoryCollectionView)
        view.addSubview(listTableView)
        view.addSubview(spinner)
    }
    
    func configureLists() {
     
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        listTableView.dataSource = self
        listTableView.delegate = self

    }
    
    func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            
            
            cityLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
            cityLabel.topAnchor.constraint(equalTo: safeArea.topAnchor),
            
            changeCityButton.leadingAnchor.constraint(equalTo: cityLabel.trailingAnchor, constant: 2),
            changeCityButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 2),
            
            bannerCollectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 15),
            bannerCollectionView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 8),
            bannerCollectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            bannerCollectionView.heightAnchor.constraint(equalToConstant: 120),
            
            categoryCollectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 15),
            categoryCollectionView.topAnchor.constraint(equalTo: bannerCollectionView.bottomAnchor, constant: 8),
            categoryCollectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 32),
            
            listTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            listTableView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: 24),
            listTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            listTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
            
        ])
    }
}
