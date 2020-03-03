//
//  EntryTableViewCell.swift
//  NotificationPatternsJournal
//
//  Created by Anthroman on 3/3/20.
//  Copyright © 2020 Trevor Walker. All rights reserved.
//

import UIKit

protocol EntryTableViewCellDelegate: class {
    func switchToggledOnCell(cell: EntryTableViewCell)
}

class EntryTableViewCell: UITableViewCell {

    //MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var higherOrLower: UILabel!
    @IBOutlet weak var isEnabled: UISwitch!

    //MARK: - Properties
    var entry: Entry?
    weak var delegate: EntryTableViewCellDelegate?
    
    //MARK: - Helper Functions
    func setEntry(entry: Entry, averageHappiness: Int) {
        self.entry = entry
        updateUI(averageHappiness: averageHappiness)
    }
    
    func updateUI(averageHappiness: Int) {
        guard let entry = entry else {return}
        titleLabel.text = entry.title
        isEnabled.isOn = entry.isIncluded
        higherOrLower.text = entry.happiness >= averageHappiness ? "Higher" : "Lower"
    }
    
    func createObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: notificationKey, object: nil)
    }
    
    // toggled the IsIncluded Value
    @IBAction func toggledIsIncluded(_ sender: UISwitch) {
        delegate?.switchToggledOnCell(cell: self)
    }
}
