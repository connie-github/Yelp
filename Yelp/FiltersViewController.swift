//
//  FiltersViewController.swift
//  Yelp
//

import UIKit

let sections = ["", "Distance", "Sort By", "Category"]
let distance_values: [Float?] = [nil, 483, 1609, 8047, 32187] // 0.3, 1, 5, 20 miles
let distance_dropdown: [String] = ["Auto", "0.3 miles", "1 mile", "5 miles", "20 miles"]
let sort_values: [YelpSortMode] = [.BestMatched, .Distance, .HighestRated]
let sort_dropdown: [String] = ["Best Match", "Distance", "Rating"]
let categories: [[String:String]] = [
    ["name" : "Afghan", "code" : "afghani"],
    ["name" : "African", "code" : "african"],
    ["name" : "American (New)", "code" : "newamerican"],
    ["name" : "American (Traditional)", "code" : "tradamerican"],
    ["name" : "Arabian", "code" : "arabian"],
    ["name" : "Argentine", "code" : "argentine"],
    ["name" : "Armenian", "code" : "armenian"],
    ["name" : "Asian Fusion", "code" : "asianfusion"],
    ["name" : "Australian", "code" : "australian"],
    ["name" : "Austrian", "code" : "austrian"],
    ["name" : "Bangladeshi", "code" : "bangladeshi"],
    ["name" : "Barbeque", "code" : "bbq"],
    ["name" : "Basque", "code" : "basque"],
    ["name" : "Belgian", "code" : "belgian"],
    ["name" : "Brasseries", "code" : "brasseries"],
    ["name" : "Brazilian", "code" : "brazilian"],
    ["name" : "Breakfast & Brunch", "code" : "breakfast_brunch"],
    ["name" : "British", "code" : "british"],
    ["name" : "Buffets", "code" : "buffets"],
    ["name" : "Burgers", "code" : "burgers"],
    ["name" : "Burmese", "code" : "burmese"],
    ["name" : "Cafes", "code" : "cafes"],
    ["name" : "Cafeteria", "code" : "cafeteria"],
    ["name" : "Cajun/Creole", "code" : "cajun"],
    ["name" : "Cambodian", "code" : "cambodian"],
    ["name" : "Caribbean", "code" : "caribbean"],
    ["name" : "Catalan", "code" : "catalan"],
    ["name" : "Cheesesteaks", "code" : "cheesesteaks"],
    ["name" : "Chicken Wings", "code" : "chicken_wings"],
    ["name" : "Chinese", "code" : "chinese"],
    ["name" : "Comfort Food", "code" : "comfortfood"],
    ["name" : "Creperies", "code" : "creperies"],
    ["name" : "Cuban", "code" : "cuban"],
    ["name" : "Czech", "code" : "czech"],
    ["name" : "Delis", "code" : "delis"],
    ["name" : "Diners", "code" : "diners"],
    ["name" : "Ethiopian", "code" : "ethiopian"],
    ["name" : "Fast Food", "code" : "hotdogs"],
    ["name" : "Filipino", "code" : "filipino"],
    ["name" : "Fish & Chips", "code" : "fishnchips"],
    ["name" : "Fondue", "code" : "fondue"],
    ["name" : "Food Court", "code" : "food_court"],
    ["name" : "Food Stands", "code" : "foodstands"],
    ["name" : "French", "code" : "french"],
    ["name" : "Gastropubs", "code" : "gastropubs"],
    ["name" : "German", "code" : "german"],
    ["name" : "Gluten-Free", "code" : "gluten_free"],
    ["name" : "Greek", "code" : "greek"],
    ["name" : "Halal", "code" : "halal"],
    ["name" : "Hawaiian", "code" : "hawaiian"],
    ["name" : "Himalayan/Nepalese", "code" : "himalayan"],
    ["name" : "Hot Dogs", "code" : "hotdog"],
    ["name" : "Hot Pot", "code" : "hotpot"],
    ["name" : "Hungarian", "code" : "hungarian"],
    ["name" : "Iberian", "code" : "iberian"],
    ["name" : "Indian", "code" : "indpak"],
    ["name" : "Indonesian", "code" : "indonesian"],
    ["name" : "Irish", "code" : "irish"],
    ["name" : "Italian", "code" : "italian"],
    ["name" : "Japanese", "code" : "japanese"],
    ["name" : "Korean", "code" : "korean"],
    ["name" : "Kosher", "code" : "kosher"],
    ["name" : "Laotian", "code" : "laotian"],
    ["name" : "Latin American", "code" : "latin"],
    ["name" : "Live/Raw Food", "code" : "raw_food"],
    ["name" : "Malaysian", "code" : "malaysian"],
    ["name" : "Mediterranean", "code" : "mediterranean"],
    ["name" : "Mexican", "code" : "mexican"],
    ["name" : "Middle Eastern", "code" : "mideastern"],
    ["name" : "Modern European", "code" : "modern_european"],
    ["name" : "Mongolian", "code" : "mongolian"],
    ["name" : "Moroccan", "code" : "moroccan"],
    ["name" : "Pakistani", "code" : "pakistani"],
    ["name" : "Persian/Iranian", "code" : "persian"],
    ["name" : "Peruvian", "code" : "peruvian"],
    ["name" : "Pizza", "code" : "pizza"],
    ["name" : "Polish", "code" : "polish"],
    ["name" : "Portuguese", "code" : "portuguese"],
    ["name" : "Russian", "code" : "russian"],
    ["name" : "Salad", "code" : "salad"],
    ["name" : "Sandwiches", "code" : "sandwiches"],
    ["name" : "Scandinavian", "code" : "scandinavian"],
    ["name" : "Scottish", "code" : "scottish"],
    ["name" : "Seafood", "code" : "seafood"],
    ["name" : "Singaporean", "code" : "singaporean"],
    ["name" : "Slovakian", "code" : "slovakian"],
    ["name" : "Soul Food", "code" : "soulfood"],
    ["name" : "Soup", "code" : "soup"],
    ["name" : "Southern", "code" : "southern"],
    ["name" : "Spanish", "code" : "spanish"],
    ["name" : "Steakhouses", "code" : "steak"],
    ["name" : "Sushi Bars", "code" : "sushi"],
    ["name" : "Taiwanese", "code" : "taiwanese"],
    ["name" : "Tapas Bars", "code" : "tapas"],
    ["name" : "Tapas/Small Plates", "code" : "tapasmallplates"],
    ["name" : "Tex-Mex", "code" : "tex-mex"],
    ["name" : "Thai", "code" : "thai"],
    ["name" : "Turkish", "code" : "turkish"],
    ["name" : "Ukrainian", "code" : "ukrainian"],
    ["name" : "Uzbek", "code" : "uzbek"],
    ["name" : "Vegan", "code" : "vegan"],
    ["name" : "Vegetarian", "code" : "vegetarian"],
    ["name" : "Vietnamese", "code" : "vietnamese"]
]

protocol FiltersViewControllerDelegate {
    func didUpdateFilters(filters: Filters)
}

class FiltersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SwitchCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    var filters: Filters?
    var delegate: FiltersViewControllerDelegate?
    
    var distanceDropdownExpanded = false
    var sortDropdownExpanded = false
    var categories : [[String:String]]!
    var categorySwitchStates = [Int:Bool]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 40
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 196/255.0, green: 18/255.0, blue: 0/255.0, alpha: 1.0)
    }
    
    @IBAction func onCancelButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onSearchButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        var filters = [String : AnyObject]()
        
        var selectedCategories = [String]()
        for (row, isSelected) in categorySwitchStates {
            if isSelected {
                selectedCategories.append(categories[row]["code"]!)
            }
        }
        if selectedCategories.count > 0 {
            filters["categories"] = selectedCategories
        }
        
        delegate?.filtersViewController?(self, didUpdateFilters: filters)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return distanceDropdownExpanded ? distance_dropdown.count : 1
        case 2:
            return sortDropdownExpanded ? sort_dropdown.count : 1
        case 3:
            return categories.count
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SwitchCell", forIndexPath: indexPath) as! SwitchCell
        
        if indexPath.section == 0 {
            cell.switchLabel.text = "Offering a Deal"
        }
        else if indexPath.section == 1 {

        }
        else if indexPath.section == 2 {

        }
        else {
            cell.switchLabel.text = categories[indexPath.row]["name"]
            cell.onSwitch.on = categorySwitchStates[indexPath.row] ?? false

        }
        
        cell.delegate = self
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    func switchCell(switchCell: SwitchCell, didChangeValue value: Bool) {
        let indexPath = tableView.indexPathForCell(switchCell)!
        categorySwitchStates[indexPath.row] = value
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
