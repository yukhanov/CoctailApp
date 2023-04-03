//
//  MenuViewController.swift
//  CoctailApp
//
//  Created by Сергей Юханов on 03.04.2023.
//

import UIKit

final class MenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkService.shared.getData { result in
            print(result)
        }
    }
    
}
