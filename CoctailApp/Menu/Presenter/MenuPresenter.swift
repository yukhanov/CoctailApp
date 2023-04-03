//
//  MenuPresenter.swift
//  CoctailApp
//
//  Created by Сергей Юханов on 03.04.2023.
//

import UIKit

protocol MenuPresenterInput: AnyObject {
    var drinks: [Drink] { get set }
    var images: [UIImage] { get set }
    var categories: [String] { get set }
    func getData()
    func getImage()
    func getDrink(at index: Int) -> Drink
    func getCategory(at index: Int) -> String
    func numberOfDrinks() -> Int
    func numberOfCategories() -> Int
    func indexOfCategory(_ category: String) -> Int?
    func firstIndexOfDrink(with category: String) -> Int?
}

protocol MenuPresenterOutput: AnyObject {
    func reloadTableView()
}

class MenuPresenter: MenuPresenterInput {
    weak var view: MenuPresenterOutput?
    var drinks: [Drink] = []
    var images: [UIImage] = []
    var categories: [String] = []
    
    
    func getData() {
        NetworkService.shared.getData { [weak self] result in
            switch result {
            case .success(let drinks):
                DispatchQueue.global(qos: .utility).async {
                    guard let self = self else { return }
                    var drinks = drinks
                    
                    for i in 0..<drinks.count {
                        if let data = try? Data(contentsOf: URL(string: drinks[i].strDrinkThumb!)!) {
                            drinks[i].drinkThumbImage = data
                        }
                        
                        if let category = drinks[i].strCategory {
                            if !self.categories.contains(category) {
                                self.categories.append(category)
                            }
                        }
                    }
                    
                    self.categories = self.categories.sorted()
                    drinks = drinks.sorted(by: { $0.strCategory! < $1.strCategory! })
                    
                    DispatchQueue.main.async {
                        self.drinks = drinks
                        self.view?.reloadTableView()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func getImage() {
        NetworkService.shared.getImage { [weak self] result in
            switch result {
            case .success(let images):
                guard let images = images else { return }
                self?.images.append(images)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func getDrink(at index: Int) -> Drink {
        drinks[index]
    }
    
    func getCategory(at index: Int) -> String {
        categories[index]
    }
    
    func numberOfDrinks() -> Int {
        drinks.count
    }
    
    func numberOfCategories() -> Int {
        categories.count
    }
    
    func indexOfCategory(_ category: String) -> Int? {
        return categories.firstIndex {
            $0 == category
        }
    }
    
    func firstIndexOfDrink(with category: String) -> Int? {
        return drinks.firstIndex {
            $0.strCategory == category
        }
    }
    
    func reloadTableView() {
        
    }
    
    
}
