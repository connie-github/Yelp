//
//  SwitchCell.swift
//  Yelp
//

import UIKit

protocol SwitchCellDelegate {
    func switchCell(switchCell: SwitchCell, didChangeValue value: Bool)
}

class SwitchCell: UITableViewCell {

    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var onSwitch: UISwitch!
    
    var delegate: SwitchCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        onSwitch.onTintColor = UIColor(red: 196/255, green: 18/255, blue: 0/255, alpha: 1)

        onSwitch.addTarget(self, action: "switchValueChanged", forControlEvents: UIControlEvents.ValueChanged)
    }

<<<<<<< HEAD
    func switchValueChanged() {
        delegate?.switchCell(self, didChangeValue: onSwitch.on)
    }
    
    func populateCell(label: String, switchedOn: Bool) {
        switchLabel.text = label
        onSwitch.on = switchedOn
    }
    
||||||| merged common ancestors
=======
    func switchValueChanged() {
        delegate?.switchCell(self, didChangeValue: onSwitch.on)
    }
    
>>>>>>> 3a62027eafb51e94a152d659c15141ee1dd92c84
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}