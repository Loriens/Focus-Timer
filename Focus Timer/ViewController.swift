//
//  ViewController.swift
//  Focus Timer
//
//  Created by Vladislav on 27/03/2019.
//  Copyright © 2019 Vladislav Markov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var startStopButton: UIButton!
    private var buttonState = ButtonState.stop
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func startStopButtonPressed(_ sender: Any) {
        if buttonState == .stop {
            startStopButton.setImage(UIImage(named: "play"), for: .normal)
        } else {
            startStopButton.setImage(UIImage(named: "stop"), for: .normal)
        }
    }
    
}

