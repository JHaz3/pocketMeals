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
    
    
    // MARK: - Properties
    var meals: Meals?
    var meal: [Meal?] = []
    var mealToDisplay: Meal? {
        didSet {
            guard let mealToDisplay = mealToDisplay else { return }
            mealNameLabel.text = mealToDisplay.name
            mealInstructionsTextView.text = mealToDisplay.instructions
            mealInstructionsTextView.isEditable = false
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
            }
        }
    }
}
