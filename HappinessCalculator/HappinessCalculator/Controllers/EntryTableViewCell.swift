//
//  EntryTableViewCell.swift
//  NotificationPatternsJournal
//
//  Created by Anthroman on 3/3/20.
//  Copyright © 2020 Trevor Walker. All rights reserved.
//

import UIKit

//Declaring a protocol and allowing it to use class-level objects
protocol EntryTableViewCellDelegate: class {
    //Creates a job that the boss--or tableViewCell--can tell our intern--or tableViewController--to do.
    func switchToggledOnCell(cell: EntryTableViewCell)
}

class EntryTableViewCell: UITableViewCell {

    //MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var higherOrLower: UILabel!
    @IBOutlet weak var isEnabled: UISwitch!

    //MARK: - Properties
    var entry: Entry?
    
    //Creating our runner that will tell our intern to do something
    weak var delegate: EntryTableViewCellDelegate?
    
    //MARK: - Helper Functions
    func setEntry(entry: Entry, averageHappiness: Int) {
        self.entry = entry
        updateUI(averageHappiness: averageHappiness)
        createObserver()
    }
    
    func updateUI(averageHappiness: Int) {
        guard let entry = entry else {return}
        titleLabel.text = entry.title
        isEnabled.isOn = entry.isIncluded
        higherOrLower.text = entry.happiness >= averageHappiness ? "Higher" : "Lower"
    }
    
    func createObserver() {
        // Creating our person who will listen for our notification, then call recalculate happiness
        NotificationCenter.default.addObserver(self, selector: #selector(recalculateHappiness), name: notificationKey, object: nil)
    }
    
    @objc func recalculateHappiness(notification: NSNotification) {
        guard let averageHappiness = notification.object as? Int else {return}
        
        updateUI(averageHappiness: averageHappiness)
    }
    
    // toggled the IsIncluded Value
    @IBAction func toggledIsIncludedValue(_ sender: UISwitch) {
        //Telling our runner to go tell our intern to do something
        delegate?.switchToggledOnCell(cell: self)
    }
}
