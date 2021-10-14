//
//  CategoryTableViewCell.swift
//  PocketMeals
//
//  Created by Jake Haslam on 10/12/21.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

// MARK: - Outlets
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    
    var category: Category? {
        
        didSet {
            guard let category = category else { return }
            categoryNameLabel.text = category.name
            
            NetworkController.fetchImage(forThumb: category.categoryThumbnail) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let image):
                    DispatchQueue.main.async {
                        self.categoryImage.image = image
                        self.categoryImage.layer.cornerRadius = 50
                    }
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---/n \(error)")
                }
            }
        }
    }
}
