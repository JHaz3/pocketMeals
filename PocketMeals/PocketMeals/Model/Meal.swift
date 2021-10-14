//
//  Meal.swift
//  PocketMeals
//
//  Created by Jake Haslam on 10/12/21.
//

import Foundation

struct Category {
    let name: String
    let categoryThumbnail: String
    // Decoding our JSON by hand casting our objects as types that swift accepts, This allows us to iterate through ingredients and measurements so we can append them to an array if they have non-null values
    static func decode(from data: [String: Any]) -> Category? {
        guard let name = data["strCategory"] as? String,
              let categoryThumbnail = data["strCategoryThumb"] as? String
        else { return nil }
        
        return Category(name: name, categoryThumbnail: categoryThumbnail)
    }
}

struct Meal {
    let name: String
    let imageThumb: String
    let id: String
    
    static func decode(from data: [String: Any]) -> Meal? {
        guard let name = data["strMeal"] as? String,
              let imageThumb = data["strMealThumb"] as? String,
              let id = data["idMeal"] as? String
        else { return nil }
        
        return Meal(name: name, imageThumb: imageThumb, id: id)
    }
}

struct MealDetail {
    let name: String
    let instructions: String
    let mealThumb: String
    let ingredients: [Ingredient]
    
    static func decode(from data: [String : Any]) -> MealDetail? {
        guard let name = data["strMeal"] as? String,
              let instructions = data["strInstructions"] as? String,
              let mealThumb = data["strMealThumb"] as? String
        else { return nil }
        // Appending ingredients and measurements with none null & non-empty values this ensures that the objects we want to display to the user exists.
        var ingredients: [Ingredient] = []
        for i in 1...20 {
            if let ing = data["strIngredient\(i)"] as? String, let meas = data["strMeasure\(i)"] as? String {
                if ing != "<null>" && !ing.isEmpty {
                    ingredients.append(Ingredient(ingredient: ing, measurement: meas))
                } else {
                    break
                }
            }
        }
        return MealDetail(name: name, instructions: instructions, mealThumb: mealThumb, ingredients: ingredients)
    }
}

struct Ingredient {
    let ingredient: String
    let measurement: String
}
