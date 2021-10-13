//
//  Meal.swift
//  PocketMeals
//
//  Created by Jake Haslam on 10/12/21.
//

import Foundation

struct TopLevelObject: Decodable {
    let categories: [Category]
}

struct Category: Decodable {
    let categoryID: String
    let name: String
    let categoryThumbnail: String
    
    enum CodingKeys: String, CodingKey {
        case categoryID = "idCategory"
        case name = "strCategory"
        case categoryThumbnail = "strCategoryThumb"
    }
}


struct SecondLevelObject: Decodable {
    let meals: [Meals]
}

struct Meals: Decodable {
    let name: String
    let mealID: String
    let mealsImage: String
    
    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case mealID = "idMeal"
        case mealsImage = "strMealThumb"
        
        
    }
    
    struct Meal: Decodable {
        let name: String
        let instructions: String
        //let mealImage: String
        
        enum CodingKeys: String, CodingKey {
            case name = "strMeal"
            case instructions = "strInstructions"
            //case mealImage = "strMealThumb"
        }
    }
    
}
