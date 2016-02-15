//
//  Filters.swift
//  Yelp
//

import UIKit

class Filters: NSObject {
    var term: String?
    var deals: Bool?
    var radius: Float?
    var sort: YelpSortMode?
    var categories: [String]?
    
    init(term: String?, sort: YelpSortMode?, categories: [String]?, deals: Bool?, radius: Float?) {
        self.term = "Restaurants"
        self.deals = false
        self.radius = nil
        self.sort = .BestMatched
        self.categories = []
    }
}