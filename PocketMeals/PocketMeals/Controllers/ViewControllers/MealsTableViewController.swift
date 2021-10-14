//
//  MealsTableViewController.swift
//  PocketMeals
//
//  Created by Jake Haslam on 10/12/21.
//

import UIKit

class MealsTableViewController: UITableViewController {
    
    // MARK: - Properties
    var meals: [Meals] = []
    var category: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mealsCell", for: indexPath) as?
                MealsTableViewCell else { return UITableViewCell() }
        let meal = meals[indexPath.row]
        cell.meals = meal
        
        return cell
    }
    
    func configureViews() {
        guard let category = category else { return }
        
        MealController.fetchMealsInCategory(category: category.name ) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let meals):
                    self.meals = meals.sorted(by: { $0.name < $1.name })
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error,error.localizedDescription)
                }
            }
        }
    }
     // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "showMeal" {
             guard let index = tableView.indexPathForSelectedRow,
                   let destination = segue.destination as? MealDetailViewController else { return }
             let meal = self.meals[index.row]
             destination.meals = meal
         }
     }
    
}// End of Class
