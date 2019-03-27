//
//  ViewController.swift
//  Focus Timer
//
//  Created by Vladislav on 27/03/2019.
//  Copyright © 2019 Vladislav Markov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var startPauseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startPauseButton.layer.cornerRadius = startPauseButton.frame.width / 2
    }


}

