<<<<<<< HEAD
//
//  DropdownCell.swift
//  Yelp
//

import UIKit

class DropdownCell: UITableViewCell {
    @IBOutlet weak var dropdownLabel: UILabel!
    @IBOutlet weak var dropdownIcon: UIImageView!

    enum DropdownState : String {
        case Collapsed = "down-arrow"
        case Selected = "circle-check"
        case Empty = "circle"
        
        func getIcon() -> UIImage {
            return UIImage(named: self.rawValue)!
        }
    }
    
    func populateCell(label: String, state: DropdownState) {
        dropdownLabel.text = label
        dropdownIcon.image = state.getIcon()
    }
}
||||||| merged common ancestors
=======
//
//  DropdownCell.swift
//  Yelp
//

import UIKit

class DropdownCell: UITableViewCell {
    @IBOutlet weak var dropdownLabel: UILabel!
    @IBOutlet weak var dropdownIcon: UIImageView!

}
>>>>>>> 3a62027eafb51e94a152d659c15141ee1dd92c84
