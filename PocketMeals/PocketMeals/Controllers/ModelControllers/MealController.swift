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
    static private let mealsInCategoryEndpoint = "filter.php?c="
    static private let mealDetailEndpoint = "lookup.php?i="
    
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
    
}// End of Class
