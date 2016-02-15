//
//  Filters.swift
//  Yelp
//

import UIKit

class Filters {
    var term: String?
    var deals: Bool?
    var radius: Float?
    var sort: YelpSortMode?
    var categories: [String]?
    
    init() {
        self.term = "Restaurants"
        self.deals = false
        self.radius = nil
        self.sort = .BestMatched
        self.categories = []
    }
}