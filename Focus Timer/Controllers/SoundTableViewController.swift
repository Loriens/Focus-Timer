//
//  SoundTableViewController.swift
//  Focus Timer
//
//  Created by Vladislav on 29/03/2019.
//  Copyright © 2019 Vladislav Markov. All rights reserved.
//

import UIKit

class SoundTableViewController: UITableViewController {
    
    var player: CustomPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        player.changeSound(soundID: Const.sounds[indexPath.item].1)
        player.play()
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
