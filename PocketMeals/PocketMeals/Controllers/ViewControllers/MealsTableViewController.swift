//
//  MealsTableViewController.swift
//  PocketMeals
//
//  Created by Jake Haslam on 10/12/21.
//

import UIKit

class MealsTableViewController: UITableViewController {
    
    // MARK: - Properties
    var meals: [Meal] = []
    var category: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        tableView.reloadData()
    }
    
    private func configureViews() {
        view.backgroundColor = .systemBackground
        guard let category = category else { return }
        
        NetworkController.fetchMealsInCategory(category: category.name ) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let meals):
                    self.meals = meals.sorted(by: { $0.name < $1.name })
                    self.title = category.name
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error,error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mealsCell", for: indexPath) as?
                MealsTableViewCell else { return UITableViewCell() }
        let meal = meals[indexPath.row]
        cell.meal = meal
        
        return cell
    }
    
     // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "showMeal" {
             guard let index = tableView.indexPathForSelectedRow,
                   let destination = segue.destination as? MealDetailViewController else { return }
             let meal = self.meals[index.row]
             destination.mealId = meal.id
         }
     }
}// End of Class
