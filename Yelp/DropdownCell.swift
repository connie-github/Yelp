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
