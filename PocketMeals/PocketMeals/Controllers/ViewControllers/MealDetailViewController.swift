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
    @IBOutlet weak var mealInstructionsTextView: UITextView!
    @IBOutlet weak var mealImage: UIImageView!
    
    
    // MARK: - Properties
    var meals: Meals?
    var meal: [Meal?] = []
    var mealToDisplay: Meal? {
        didSet {
            guard let mealToDisplay = mealToDisplay else { return }
            mealNameLabel.text = mealToDisplay.name
            mealInstructionsTextView.text = mealToDisplay.instructions
            mealInstructionsTextView.isEditable = false
            MealController.fetchMealImage(for: mealToDisplay) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let image):
                        self.mealImage.image = image
                        self.mealImage.layer.cornerRadius = 20
                    case .failure(let error):
                        print(error, error.localizedDescription)
                    }
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    
    func configureViews() {
        guard let meal = meals?.mealID else { return }
        
        MealController.fetchMeal(for: meal) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let meal):
                    self.meal = meal
                    self.mealToDisplay = meal[0]
                case .failure(let error):
                    print(error, error.localizedDescription)
                }
//                var ingredients: [(ing: String, meas: String)] {
//                    
//                    var ingredients = [mealToDisplay.strIngredient1...]
//                    var measurements = [mealToDisplay.strMeasurement1...]
//                    for (index, ingredient) in ingredients.enumerated() {
//                        if let ingredient = ingredient, let measurement = measurements[safe: index] {
//                        
//                        }
//                    }
//                }
            }
        }
    }

}// End of Class

