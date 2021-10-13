//
//  MealsTableViewCell.swift
//  PocketMeals
//
//  Created by Jake Haslam on 10/12/21.
//

import UIKit

class MealsTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var mealsImage: UIImageView!
    @IBOutlet weak var mealsNameLabel: UILabel!
    
    
    var meals: Meals? {
        
        didSet {
            guard let meal = meals else { return }
            mealsNameLabel.text = meal.name
            
            MealController.fetchMealsImage(for: meal) { result in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async { self.mealsImage.image = image }
                case .failure(let error):
                    print(error, error.localizedDescription)
                }
            }
        }
    }
}
