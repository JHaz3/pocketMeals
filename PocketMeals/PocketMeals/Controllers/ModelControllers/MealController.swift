//
//  MealController.swift
//  PocketMeals
//
//  Created by Jake Haslam on 10/12/21.
//

import UIKit

class MealController {
    
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
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                completion(.success(topLevelObject.categories))
            } catch {
                print(error.localizedDescription)
                return completion(.failure(.thrown(error)))
            }
        }.resume()
    }
    
    static func fetchCategoryImage(for category: Category, completion: @escaping (Result<UIImage, MealError>) -> Void) {
        guard let categoryThumbnail = URL(string: category.categoryThumbnail) else { return completion(.failure(.noData)) }
        
        URLSession.shared.dataTask(with: categoryThumbnail) { data, _, error in
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
    
    // MARK: - Meals Filter Networking
    static func fetchMealsInCategory(category: String, completion: @escaping (Result<[Meals], MealError>) -> Void) {
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
                let secondLevelObject = try JSONDecoder().decode(SecondLevelObject.self, from: data)
                completion(.success(secondLevelObject.meals))
            } catch {
                print(error, error.localizedDescription)
                return completion(.failure(.thrown(error)))
            }
        }.resume()
    }
    
    static func fetchMealsImage(for meal: Meals, completion: @escaping (Result<UIImage, MealError>) -> Void) {
        guard let mealsThumbnail = URL(string: meal.mealsImage) else { return completion(.failure(.noData)) }
        
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
    
    // MARK: - Meal Networking
    static func fetchMeal(for meal: String, completion: @escaping (Result<[Meal], MealError>) -> Void) {
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        let mealURL = baseURL.appendingPathComponent(mealDetailEndpoint)
        let phpURL = mealURL.appendingPathExtension(phpExtension)
        
        var urlComponents = URLComponents(url: phpURL, resolvingAgainstBaseURL: true)
        
        urlComponents?.queryItems = [
            URLQueryItem(name: mealIDKey, value: meal)
        ]
        
        guard let finalURL = urlComponents?.url else { return completion(.failure(.invalidURL)) }
        print("finalURL = \(finalURL)")
        
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.noData))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let thirdLevelObject = try JSONDecoder().decode(ThirdLevelObject.self, from: data)
                return completion(.success(thirdLevelObject.meal))
            } catch {
                print(error, error.localizedDescription)
                return completion(.failure(.thrown(error)))
            }
        }.resume()
    }
    
    
}// End of Class
