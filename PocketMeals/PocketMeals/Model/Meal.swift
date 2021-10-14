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
    let name: String
    let categoryThumbnail: String
    
    enum CodingKeys: String, CodingKey {
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
}

struct ThirdLevelObject: Decodable {
    let meal: [Meal]
    
    enum CodingKeys: String, CodingKey {
        case meal = "meals" }
}

    struct Meal: Decodable {
        let name: String
        let instructions: String
        let mealID: String
        let mealImage: String
        let strIngredient1:String? = "strIngredient1"
        let strIngredient2:String? = "strIngredient2"
        let strIngredient3:String? = "strIngredient3"
        let strIngredient4:String? = "strIngredient4"
        let strIngredient5:String? = "strIngredient5"
        let strIngredient6:String? = "strIngredient6"
        let strIngredient7:String? = "strIngredient7"
        let strIngredient8:String? = "strIngredient8"
        let strIngredient9:String? = "strIngredient9"
        let strIngredient10: String? = "strIngredient10"
        let strIngredient11: String? = "strIngredient11"
        let strIngredient12: String? = "strIngredient12"
        let strIngredient13: String? = "strIngredient13"
        let strIngredient14: String? = "strIngredient14"
        let strIngredient15: String? = "strIngredient15"
        let strIngredient16: String? = "strIngredient16"
        let strIngredient17: String? = "strIngredient17"
        let strIngredient18: String? = "strIngredient18"
        let strIngredient19: String? = "strIngredient19"
        let strIngredient20: String? = "strIngredient20"
        let strMeasure1: String? = "strMeasure1"
        let strMeasure2: String? = "strMeasure2"
        let strMeasure3: String? = "strMeasure3"
        let strMeasure4: String? = "strMeasure4"
        let strMeasure5: String? = "strMeasure5"
        let strMeasure6: String? = "strMeasure6"
        let strMeasure7: String? = "strMeasure7"
        let strMeasure8: String? = "strMeasure8"
        let strMeasure9: String? = "strMeasure9"
        let strMeasure10: String? = "strMeasure10"
        let strMeasure11: String? = "strMeasure11"
        let strMeasure12: String? = "strMeasure12"
        let strMeasure13: String? = "strMeasure13"
        let strMeasure14: String? = "strMeasure14"
        let strMeasure15: String? = "strMeasure15"
        let strMeasure16: String? = "strMeasure16"
        let strMeasure17: String? = "strMeasure17"
        let strMeasure18: String? = "strMeasure18"
        let strMeasure19: String? = "strMeasure19"
        let strMeasure20: String? = "strMeasure20"
        
        
        enum CodingKeys: String, CodingKey {
            case name = "strMeal"
            case instructions = "strInstructions"
            case mealID = "idMeal"
            case mealImage = "strMealThumb"
            
        }
    }
