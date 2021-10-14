//
//  MealDetailViewController.swift
//  PocketMeals
//
//  Created by Jake Haslam on 10/13/21.
//

import UIKit

class MealDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var mealId: String = ""
    var meal: MealDetail?
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureViews()
    }
    
    private func configureViews() {
        NetworkController.fetchMeal(for: mealId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let meal):
                DispatchQueue.main.async {
                    self.title = meal.name
                    self.tableView.reloadData()
                }
                self.meal = meal

                NetworkController.fetchImage(forThumb: meal.mealThumb) { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let image):
                            DispatchQueue.main.async { self.mealImage.image = image }
                        case .failure(let error):
                            print(error, error.localizedDescription)
                        }
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    private func updateViews() {
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 500
    }
    
}// End of Class

extension MealDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // We need an extra row for our Directions
        return (meal?.ingredients.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mealDetailCell", for: indexPath)
        // Allowing our text to wrap
        cell.textLabel?.numberOfLines = 0
        // Making sure that our Ingredients and Measurements are always above the directions
        switch indexPath.row {
        case meal?.ingredients.count ?? 0:
            cell.textLabel?.text = meal?.instructions
        default:
            let ingredient = meal?.ingredients[indexPath.row]
            cell.textLabel?.text = "\(ingredient?.ingredient ?? ""): \(ingredient?.measurement ?? "")"
        }
        return cell
    }
}
