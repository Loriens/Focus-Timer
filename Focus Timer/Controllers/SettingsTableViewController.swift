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
    @IBOutlet weak var workingTimeSlider: UISlider!
    @IBOutlet weak var breakTimeSlider: UISlider!
    
    private var stepSlider: Float = 5
    
    override func viewDidLoad() {
        if let workingTime = UserDefaults.standard.object(forKey: Key.workingTime.rawValue) as? Int {
            workingTimeLabel.text = "\(workingTime)"
            workingTimeSlider.value = Float(workingTime)
        }
        
        if let breakingTime = UserDefaults.standard.object(forKey: Key.breakingTime.rawValue) as? Int {
            breakTimeLabel.text = "\(breakingTime)"
            breakTimeSlider.value = Float(breakingTime)
        }
        
        title = "Настройки"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.reuseIdentifier == "AboutCell" {
            performSegue(withIdentifier: "showAboutApp", sender: nil)
        }
    }
    
    @IBAction func workingTimeSliderValueChanged(_ sender: Any) {
        guard let slider = sender as? UISlider else {
            return
        }
        
        let roundedValue = round(slider.value / stepSlider) * stepSlider
        slider.value = roundedValue
        workingTimeLabel.text = "\(Int(roundedValue))"
        UserDefaults.standard.set(Int(roundedValue), forKey: Key.workingTime.rawValue)
    }
    
    @IBAction func breakTimeSliderValueChanged(_ sender: Any) {
        guard let slider = sender as? UISlider else {
            return
        }
        
        let roundedValue = round(slider.value / stepSlider) * stepSlider
        slider.value = roundedValue
        breakTimeLabel.text = "\(Int(roundedValue))"
        UserDefaults.standard.set(Int(roundedValue), forKey: Key.breakingTime.rawValue)
    }
    
}
