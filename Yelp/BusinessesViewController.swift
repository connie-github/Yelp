//
//  BusinessesViewController.swift
//  Yelp
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, FiltersViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    var businesses: [Business]!
    var filters: Filters? = Filters()
    var searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        searchBar.delegate = self
        searchBar.placeholder = "Restaurants"
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        searchBar.tintColor = UIColor.whiteColor()
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 196/255, green: 18/255, blue: 0/255, alpha: 1)
        navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
    
        fetchBusinesses()
    }
    
    func fetchBusinesses() {
        if let filters = filters {
            Business.searchWithTerm(filters.term!, sort: filters.sort, categories: filters.categories, deals: filters.deals, radius: filters.radius) { (businesses: [Business]!, error: NSError!) -> Void in
                self.businesses = businesses
                self.tableView.reloadData()
            }
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil {
            return businesses!.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
        let business = businesses[indexPath.row]
        if let imageUrl = business.imageURL {
            cell.thumbImageView.setImageWithURL(imageUrl)
        }
        cell.nameLabel.text = business.name
        cell.addressLabel.text = business.address
        cell.ratingImageView.setImageWithURL(business.ratingImageURL!)
        cell.categoriesLabel.text = business.categories
        cell.distanceLabel.text = business.distance
        cell.reviewCountLabel.text = "\(business.reviewCount!) Reviews"
        
        return cell
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            filters!.term = "Restaurants"
        } else {
            filters!.term = searchText
        }
        fetchBusinesses()
    }

    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func didUpdateFilters(filters: Filters) {
        self.filters = filters
        fetchBusinesses()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navigationController = segue.destinationViewController as! UINavigationController
        let filtersViewController = navigationController.topViewController as! FiltersViewController
        
        filtersViewController.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
