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
    
    
    var meal: Meal? {
        
        didSet {
            guard let meal = meal else { return }
            mealsNameLabel.text = meal.name
            NetworkController.fetchImage(forThumb: meal.imageThumb) { result in
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        self.mealsImage.image = image
                        self.mealsImage.layer.cornerRadius = 10
                    }
                case .failure(let error):
                    print(error, error.localizedDescription)
                }
            }
        }
    }
}
