<<<<<<< HEAD
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
||||||| merged common ancestors
=======
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
>>>>>>> 3a62027eafb51e94a152d659c15141ee1dd92c84
