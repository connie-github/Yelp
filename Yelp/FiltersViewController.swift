//
//  FiltersViewController.swift
//  Yelp
//

import UIKit

let sections : [String] = ["", "Distance", "Sort By", "Category"]
let distance_values : [Float?] = [nil, 483, 1609, 8047, 32187]
let distance_dropdown : [String] = ["Auto", "0.3 miles", "1 mile", "5 miles", "20 miles"]
let sort_values : [YelpSortMode] = [.BestMatched, .Distance, .HighestRated]
let sort_dropdown : [String] = ["Best Match", "Distance", "Rating"]
let categories : [[String:String]] = [
    ["name" : "Barbeque", "code" : "bbq"],
    ["name" : "Brasseries", "code" : "brasseries"],
    ["name" : "Breakfast & Brunch", "code" : "breakfast_brunch"],
    ["name" : "Buffets", "code" : "buffets"],
    ["name" : "Burgers", "code" : "burgers"],
    ["name" : "Cafes", "code" : "cafes"],
    ["name" : "Cafeteria", "code" : "cafeteria"],
    ["name" : "Comfort Food", "code" : "comfortfood"],
    ["name" : "Creperies", "code" : "creperies"],
    ["name" : "Delis", "code" : "delis"],
    ["name" : "Diners", "code" : "diners"],
    ["name" : "Fast Food", "code" : "hotdogs"],
    ["name" : "Food Court", "code" : "food_court"],
    ["name" : "Food Stands", "code" : "foodstands"],
    ["name" : "Gluten-Free", "code" : "gluten_free"],
    ["name" : "Kosher", "code" : "kosher"],
    ["name" : "Pizza", "code" : "pizza"],
    ["name" : "Salad", "code" : "salad"],
    ["name" : "Sandwiches", "code" : "sandwiches"],
    ["name" : "Seafood", "code" : "seafood"],
    ["name" : "Soul Food", "code" : "soulfood"],
    ["name" : "Soup", "code" : "soup"],
    ["name" : "Southern", "code" : "southern"],
    ["name" : "Steakhouses", "code" : "steak"],
    ["name" : "Sushi Bars", "code" : "sushi"],
    ["name" : "Tapas Bars", "code" : "tapas"],
    ["name" : "Vegan", "code" : "vegan"],
    ["name" : "Vegetarian", "code" : "vegetarian"],
]

protocol FiltersViewControllerDelegate {
    func didUpdateFilters(filters: Filters)
}

class FiltersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SwitchCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    var filters: Filters? = Filters()
    var delegate: FiltersViewControllerDelegate?
    
    var distanceDropdownExpanded : Bool = false
    var sortDropdownExpanded : Bool = false
    var categoriesExpanded : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 40
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 196/255, green: 18/255, blue: 0/255, alpha: 1)
        navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.titleTextAttributes = titleDict as! [String: UIColor]
    }

    @IBAction func onCancelButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onSearchButton(sender: AnyObject) {
        delegate?.didUpdateFilters(filters!)
        dismissViewControllerAnimated(true, completion: nil)
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
            return categoriesExpanded ? categories.count : 5
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
        // deal
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("SwitchCell", forIndexPath: indexPath) as! SwitchCell
            cell.delegate = self
            cell.populateCell("Offering a Deal", switchedOn: (filters?.deals!)!)
            return cell
        }
        // distance
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("DropdownCell", forIndexPath: indexPath) as! DropdownCell
            if distanceDropdownExpanded {
                let state = (filters!.radius == distance_values[indexPath.row]) ? DropdownCell.DropdownState.Selected : DropdownCell.DropdownState.Empty
                cell.populateCell(distance_dropdown[indexPath.row], state: state)
            } else {
                let selectedIndex = distance_values.indexOf({(radius: Float?) in return radius ?? 0 == filters!.radius ?? 0}) ?? 0
                cell.populateCell(distance_dropdown[selectedIndex], state: DropdownCell.DropdownState.Collapsed)
            }
            return cell
        }
        // sort by
        else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCellWithIdentifier("DropdownCell", forIndexPath: indexPath) as! DropdownCell
            if sortDropdownExpanded {
                let state = (filters!.sort == sort_values[indexPath.row]) ? DropdownCell.DropdownState.Selected : DropdownCell.DropdownState.Empty
                cell.populateCell(sort_dropdown[indexPath.row], state: state)
            } else {
                let selectedIndex = sort_values.indexOf({(sort: YelpSortMode) in return sort == filters!.sort}) ?? 0
                cell.populateCell(sort_dropdown[selectedIndex], state: DropdownCell.DropdownState.Collapsed)
            }
            return cell

        }
        // category
        else if indexPath.section == 3 {
            if !categoriesExpanded && indexPath.row == 4 {
                let cell = tableView.dequeueReusableCellWithIdentifier("SeeAllCell", forIndexPath: indexPath) as! SeeAllCell
                return cell
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier("SwitchCell", forIndexPath: indexPath) as! SwitchCell
                cell.delegate = self
                cell.populateCell(categories[indexPath.row]["name"]!, switchedOn: filters!.categories!.indexOf({cat in return cat == categories[indexPath.row]["code"]!}) != nil)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 1:
            if distanceDropdownExpanded {
                filters!.radius = distance_values[indexPath.row]
            }
            distanceDropdownExpanded = !distanceDropdownExpanded
            let indexSet = NSIndexSet(index: indexPath.section)
            tableView.reloadSections(indexSet, withRowAnimation: .Fade)
            break
        case 2:
            if sortDropdownExpanded {
                filters!.sort = sort_values[indexPath.row]
            }
            sortDropdownExpanded = !sortDropdownExpanded
            let indexSet = NSIndexSet(index: indexPath.section)
            tableView.reloadSections(indexSet, withRowAnimation: .Fade)
            break
        case 3:
            if !categoriesExpanded && indexPath.row == 4 {
                categoriesExpanded = true
                tableView.reloadData()
            }
        default:
            return
        }
    }


    func switchCell(switchCell: SwitchCell, didChangeValue value: Bool) {
        let indexPath = tableView.indexPathForCell(switchCell)!
        switch indexPath.section {
        // deal
        case 0:
            filters?.deals = value
        // category
        case 3:
            let selectedCategory = categories[indexPath.row]
            if value {
                filters?.categories?.append(selectedCategory["code"]!)
            } else {
                let index = filters?.categories?.indexOf(selectedCategory["code"]!)
                if let index = index {
                    filters?.categories?.removeAtIndex(index)
                }
            }
        default:
            return
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


// full category list:
//["name" : "Afghan", "code" : "afghani"],
//["name" : "African", "code" : "african"],
//["name" : "American (New)", "code" : "newamerican"],
//["name" : "American (Traditional)", "code" : "tradamerican"],
//["name" : "Arabian", "code" : "arabian"],
//["name" : "Argentine", "code" : "argentine"],
//["name" : "Armenian", "code" : "armenian"],
//["name" : "Asian Fusion", "code" : "asianfusion"],
//["name" : "Australian", "code" : "australian"],
//["name" : "Austrian", "code" : "austrian"],
//["name" : "Bangladeshi", "code" : "bangladeshi"],
//["name" : "Barbeque", "code" : "bbq"],
//["name" : "Basque", "code" : "basque"],
//["name" : "Belgian", "code" : "belgian"],
//["name" : "Brasseries", "code" : "brasseries"],
//["name" : "Brazilian", "code" : "brazilian"],
//["name" : "Breakfast & Brunch", "code" : "breakfast_brunch"],
//["name" : "British", "code" : "british"],
//["name" : "Buffets", "code" : "buffets"],
//["name" : "Burgers", "code" : "burgers"],
//["name" : "Burmese", "code" : "burmese"],
//["name" : "Cafes", "code" : "cafes"],
//["name" : "Cafeteria", "code" : "cafeteria"],
//["name" : "Cajun/Creole", "code" : "cajun"],
//["name" : "Cambodian", "code" : "cambodian"],
//["name" : "Caribbean", "code" : "caribbean"],
//["name" : "Catalan", "code" : "catalan"],
//["name" : "Cheesesteaks", "code" : "cheesesteaks"],
//["name" : "Chicken Wings", "code" : "chicken_wings"],
//["name" : "Chinese", "code" : "chinese"],
//["name" : "Comfort Food", "code" : "comfortfood"],
//["name" : "Creperies", "code" : "creperies"],
//["name" : "Cuban", "code" : "cuban"],
//["name" : "Czech", "code" : "czech"],
//["name" : "Delis", "code" : "delis"],
//["name" : "Diners", "code" : "diners"],
//["name" : "Ethiopian", "code" : "ethiopian"],
//["name" : "Fast Food", "code" : "hotdogs"],
//["name" : "Filipino", "code" : "filipino"],
//["name" : "Fish & Chips", "code" : "fishnchips"],
//["name" : "Fondue", "code" : "fondue"],
//["name" : "Food Court", "code" : "food_court"],
//["name" : "Food Stands", "code" : "foodstands"],
//["name" : "French", "code" : "french"],
//["name" : "Gastropubs", "code" : "gastropubs"],
//["name" : "German", "code" : "german"],
//["name" : "Gluten-Free", "code" : "gluten_free"],
//["name" : "Greek", "code" : "greek"],
//["name" : "Halal", "code" : "halal"],
//["name" : "Hawaiian", "code" : "hawaiian"],
//["name" : "Himalayan/Nepalese", "code" : "himalayan"],
//["name" : "Hot Dogs", "code" : "hotdog"],
//["name" : "Hot Pot", "code" : "hotpot"],
//["name" : "Hungarian", "code" : "hungarian"],
//["name" : "Iberian", "code" : "iberian"],
//["name" : "Indian", "code" : "indpak"],
//["name" : "Indonesian", "code" : "indonesian"],
//["name" : "Irish", "code" : "irish"],
//["name" : "Italian", "code" : "italian"],
//["name" : "Japanese", "code" : "japanese"],
//["name" : "Korean", "code" : "korean"],
//["name" : "Kosher", "code" : "kosher"],
//["name" : "Laotian", "code" : "laotian"],
//["name" : "Latin American", "code" : "latin"],
//["name" : "Live/Raw Food", "code" : "raw_food"],
//["name" : "Malaysian", "code" : "malaysian"],
//["name" : "Mediterranean", "code" : "mediterranean"],
//["name" : "Mexican", "code" : "mexican"],
//["name" : "Middle Eastern", "code" : "mideastern"],
//["name" : "Modern European", "code" : "modern_european"],
//["name" : "Mongolian", "code" : "mongolian"],
//["name" : "Moroccan", "code" : "moroccan"],
//["name" : "Pakistani", "code" : "pakistani"],
//["name" : "Persian/Iranian", "code" : "persian"],
//["name" : "Peruvian", "code" : "peruvian"],
//["name" : "Pizza", "code" : "pizza"],
//["name" : "Polish", "code" : "polish"],
//["name" : "Portuguese", "code" : "portuguese"],
//["name" : "Russian", "code" : "russian"],
//["name" : "Salad", "code" : "salad"],
//["name" : "Sandwiches", "code" : "sandwiches"],
//["name" : "Scandinavian", "code" : "scandinavian"],
//["name" : "Scottish", "code" : "scottish"],
//["name" : "Seafood", "code" : "seafood"],
//["name" : "Singaporean", "code" : "singaporean"],
//["name" : "Slovakian", "code" : "slovakian"],
//["name" : "Soul Food", "code" : "soulfood"],
//["name" : "Soup", "code" : "soup"],
//["name" : "Southern", "code" : "southern"],
//["name" : "Spanish", "code" : "spanish"],
//["name" : "Steakhouses", "code" : "steak"],
//["name" : "Sushi Bars", "code" : "sushi"],
//["name" : "Taiwanese", "code" : "taiwanese"],
//["name" : "Tapas Bars", "code" : "tapas"],
//["name" : "Tapas/Small Plates", "code" : "tapasmallplates"],
//["name" : "Tex-Mex", "code" : "tex-mex"],
//["name" : "Thai", "code" : "thai"],
//["name" : "Turkish", "code" : "turkish"],
//["name" : "Ukrainian", "code" : "ukrainian"],
//["name" : "Uzbek", "code" : "uzbek"],
//["name" : "Vegan", "code" : "vegan"],
//["name" : "Vegetarian", "code" : "vegetarian"],
//["name" : "Vietnamese", "code" : "vietnamese"]