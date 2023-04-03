//
//  CoctailModel.swift
//  CoctailApp
//
//  Created by Сергей Юханов on 03.04.2023.
//

import Foundation

struct Drinks: Codable {
    let drinks: [Drink]
}


struct Drink: Codable {
    let strDrink: String?
    let strCategory: String?
    let strGlass: String?
    //let strIngredient1: String?
    //let strIngredient2: String?
    //let strIngredient3: String?
    let strDrinkThumb: String?
}
