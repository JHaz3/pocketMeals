//
//  MealDetailViewController.swift
//  PocketMeals
//
//  Created by Jake Haslam on 10/13/21.
//

import UIKit

class MealDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var mealNameLabel: UILabel!
    
    
    // MARK: - Properties
    var meals: Meals?
    var meal: [Meal?] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    
    func configureViews() {
        guard let meal = meals?.mealID else { return }
        
        MealController.fetchMeal(for: meal) { result in
            switch result {
            case .success(let meal):
                self.meal = meal
            case .failure(let error):
                print(error, error.localizedDescription)
            }
        }
    }
}
