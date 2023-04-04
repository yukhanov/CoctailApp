
import UIKit

protocol MenuPresenterInput: AnyObject {
    func getData(for collectionView: UICollectionView, spinner: UIActivityIndicatorView)
    func getImage()
    func drinkModel(at index: Int) -> Drink
    func categoryModel(at index: Int) -> String
    func numberOfDrinks() -> Int
    func numberOfCategories() -> Int
    func indexOfCategory(_ category: String) -> Int?
    func firstIndexOfDrink(with category: String) -> Int?
}

protocol MenuPresenterOutput: AnyObject {
    func reloadTableView()
}

class MenuPresenter {
    weak var view: MenuPresenterOutput?
    private var drinks: [Drink] = []
    private var images: [UIImage] = []
    private var categories: [String] = []
}

extension MenuPresenter: MenuPresenterInput {
    func firstIndexOfDrink(with category: String) -> Int? {
        return drinks.firstIndex {
            $0.strCategory == category
        }
    }

    func indexOfCategory(_ category: String) -> Int? {
        return categories.firstIndex {
            $0 == category
        }
    }
    
    func numberOfDrinks() -> Int {
        return drinks.count
    }
    
    func drinkModel(at index: Int) -> Drink {
        return drinks[index]
    }
    
    func numberOfCategories() -> Int {
        return categories.count
    }
    
    func categoryModel(at index: Int) -> String {
        return categories[index]
    }
    
    func getData(for collectionView: UICollectionView, spinner: UIActivityIndicatorView) {
        
        DispatchQueue.main.async {
            spinner.startAnimating()
        }
       
        // if there's internet
        NetworkService.shared.getData { [weak self] result in
            
            switch result {
            case .success(let drinks):
                DispatchQueue.global(qos: .utility).async {
                    guard let self = self else { return }
                    var drinks = drinks
                    
                    for i in 0..<drinks.count {
                        if let data = try? Data(contentsOf: URL(string: drinks[i].strDrinkThumb)!) {
                            drinks[i].drinkThumbImageData = data
                        }
                        
                        if let category = drinks[i].strCategory {
                            if !self.categories.contains(category) {
                                self.categories.append(category)
                                print(self.categories)
                            }
                            
                        }
                        
                    }
                    
                    self.categories = self.categories.sorted()
                    drinks = drinks.sorted(by: { $0.strCategory! < $1.strCategory! })
                    
    
                    DispatchQueue.main.async {
                        self.drinks = drinks
                        collectionView.reloadData()
                        spinner.stopAnimating()
                        //self.view?.reloadTableView()
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
}
