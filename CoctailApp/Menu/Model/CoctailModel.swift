//
//  CoctailModel.swift
//  CoctailApp
//
//  Created by Сергей Юханов on 03.04.2023.
//

import Foundation

public struct CoctailModel: Codable {
    var drinks: [Drink]
}

public struct Drink: Codable {
    let strDrink: String?
    let strCategory: String?
    let strInstructions: String?
    let strDrinkThumb: String
    var drinkThumbImageData: Data?
}
