//
//  SoundTableViewController.swift
//  Focus Timer
//
//  Created by Vladislav on 29/03/2019.
//  Copyright © 2019 Vladislav Markov. All rights reserved.
//

import UIKit

class SoundTableViewController: UITableViewController {
    
    private var player: CustomPlayer!
    private var checkmarNumber: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkmarNumber = UserDefaults.standard.integer(forKey: Key.soundNumber.rawValue)
        player = CustomPlayer()
        title = "Звуки"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Const.sounds.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SoundCell")!
        
        cell.textLabel?.text = Const.sounds[indexPath.item].0
        if indexPath.item == checkmarNumber {
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        player.changeSound(soundID: Const.sounds[indexPath.item].1)
        player.play()
        
        if indexPath.item != checkmarNumber {
            let oldCell = tableView.cellForRow(at: IndexPath(row: checkmarNumber, section: indexPath.section))
            oldCell?.accessoryType = .none
            
            checkmarNumber = indexPath.item
            let newCell = tableView.cellForRow(at: indexPath)
            newCell?.accessoryType = .checkmark
            UserDefaults.standard.set(checkmarNumber, forKey: Key.soundNumber.rawValue)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
