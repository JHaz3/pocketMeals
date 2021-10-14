//
//  CategoryTableViewController.swift
//  PocketMeals
//
//  Created by Jake Haslam on 10/12/21.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    
    // MARK: - Properties
    var categories: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }

    private func configureViews() {
        view.backgroundColor = .systemBackground
        NetworkController.fetchCategories() { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let categories):
                    self.categories = categories.sorted(by: { $0.name < $1.name })
                    self.title = "Categories"
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as?
        CategoryTableViewCell else { return UITableViewCell() }
        let category = categories[indexPath.row]
        cell.category = category
        
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCategory" {
            guard let index = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? MealsTableViewController else { return }
            let category = self.categories[index.row]
            destination.category = category
        }
    }
}// End of Class
