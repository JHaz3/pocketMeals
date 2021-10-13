//
//  MealError.swift
//  PocketMeals
//
//  Created by Jake Haslam on 10/12/21.
//

import Foundation

enum MealError: LocalizedError {
case thrown(Error)
case invalidURL
case noData
case badData
case unableToDelete
    var errorDescription: String? {
        switch self {
        case .thrown(let error):
            return error.localizedDescription
        case .invalidURL:
            return "Unable to reach server"
        case .noData:
            return "Server responded with no data."
        case .badData:
            return "Server responded with bad data."
        case .unableToDelete:
            return "Unable to delete at this time, try again."
        }
    }
}
