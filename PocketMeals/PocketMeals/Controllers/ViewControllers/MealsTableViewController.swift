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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MealController.fetchMealsInCategory(category: meals) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let meals):
                    self.meals = meals
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
        cell.meals = meal
        
        return cell
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
