//
//  SettingsTableViewController.swift
//  Focus Timer
//
//  Created by Vladislav on 28/03/2019.
//  Copyright © 2019 Vladislav Markov. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var workingTimeLabel: UILabel!
    @IBOutlet weak var breakTimeLabel: UILabel!
    private var stepSlider: Float = 5
    
    override func viewDidLoad() {
    }
    
    @IBAction func workingTimeSliderValueChanged(_ sender: Any) {
        guard let slider = sender as? UISlider else {
            return
        }
        
        let roundedValue = round(slider.value / stepSlider) * stepSlider
        slider.value = roundedValue
        workingTimeLabel.text = "\(Int(roundedValue))"
    }
    
    @IBAction func breakTimeSliderValueChanged(_ sender: Any) {
        guard let slider = sender as? UISlider else {
            return
        }
        
        let roundedValue = round(slider.value / stepSlider) * stepSlider
        slider.value = roundedValue
        breakTimeLabel.text = "\(Int(roundedValue))"
    }
    
}
