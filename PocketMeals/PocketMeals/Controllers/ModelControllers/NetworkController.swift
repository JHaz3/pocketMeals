//
//  MealController.swift
//  PocketMeals
//
//  Created by Jake Haslam on 10/12/21.
//

import UIKit

class NetworkController {
    
    // MARK: - Properties
    static private let baseURL = URL(string: "https://www.themealdb.com/api/json/v1/1")
    static private let categoryListEndpoint = "categories.php"
    static private let mealsInCategoryEndpoint = "filter"
    static private let mealDetailEndpoint = "lookup"
    static private let phpExtension = "php"
    static private let filterKey = "c"
    static private let mealIDKey = "i"
    
    // MARK: - Category Networking
    static func fetchCategories(completion: @escaping (Result<[Category], MealError>) -> Void) {
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        let categoriesURL = baseURL.appendingPathComponent(categoryListEndpoint)
        
        let urlComponents = URLComponents(url: categoriesURL, resolvingAgainstBaseURL: true)
        
        guard let finalURL = urlComponents?.url else { return completion(.failure(.invalidURL)) }
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                return completion(.failure(.noData))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                var categories: [Category] = []
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : [[String : Any]]], let jsonCats = json["categories"] {
                    for i in jsonCats {
                        if let category = Category.decode(from: i) {
                            categories.append(category)
                        }
                    }
                } else {
                    completion(.failure(.badData))
                }
                completion(.success(categories))
            } catch {
                print(error.localizedDescription)
                return completion(.failure(.thrown(error)))
            }
        }.resume()
    }
    
    // MARK: - Meals Filter Networking
    static func fetchMealsInCategory(category: String, completion: @escaping (Result<[Meal], MealError>) -> Void) {
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        let mealsInCategoryURL = baseURL.appendingPathComponent(mealsInCategoryEndpoint)
        let phpURL = mealsInCategoryURL.appendingPathExtension(phpExtension)
        
        var urlComponents = URLComponents(url: phpURL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [
            URLQueryItem(name: filterKey, value: category)
        ]
        
        guard let finalURL = urlComponents?.url else { return completion(.failure(.invalidURL)) }
        print("finalURL = \(finalURL)")
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let data = data else { return completion(.failure(.badData)) }
            
            do {
                var meals: [Meal] = []
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : [[String : Any]]], let jsonMeals = json["meals"] {
                    for i in jsonMeals {
                        if let meal = Meal.decode(from: i) {
                            meals.append(meal)
                        }
                    }
                } else {
                    completion(.failure(.badData))
                }
                completion(.success(meals))
            } catch {
                print(error, error.localizedDescription)
                return completion(.failure(.thrown(error)))
            }
        }.resume()
    }
    
    // MARK: - Meal Networking
    static func fetchMeal(for meal: String, completion: @escaping (Result<MealDetail, MealError>) -> Void) {
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        let mealURL = baseURL.appendingPathComponent(mealDetailEndpoint)
        let phpURL = mealURL.appendingPathExtension(phpExtension)
        
        var urlComponents = URLComponents(url: phpURL, resolvingAgainstBaseURL: true)
        
        urlComponents?.queryItems = [
            URLQueryItem(name: mealIDKey, value: meal)
        ]
        
        guard let finalURL = urlComponents?.url else { return completion(.failure(.invalidURL)) }
        
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.noData))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: [Any]] {
                    print(json)
                    guard let jsonMeal = json["meals"]?[0] as? [String : Any],
                          let meal = MealDetail.decode(from: jsonMeal) else {
                              return completion(.failure(.badData))}
                    return completion(.success(meal))
                } else {
                    return completion(.failure(.badData))
                }
            } catch {
                print(error, error.localizedDescription)
                return completion(.failure(.thrown(error)))
            }
        }.resume()
    }
    
    static func fetchImage(forThumb thumb: String, completion: @escaping (Result<UIImage, MealError>) -> Void) {
        guard let mealsThumbnail = URL(string: thumb) else { return completion(.failure(.noData)) }
        
        URLSession.shared.dataTask(with: mealsThumbnail) { data, _, error in
            if let error = error {
                return completion(.failure(.thrown(error)))
            }
            guard let data = data else {
                return completion(.failure(.noData))
            }
            guard let image = UIImage(data: data) else {
                return completion(.failure(.noData))
            }
            completion(.success(image))
        }.resume()
    }
}// End of Class
