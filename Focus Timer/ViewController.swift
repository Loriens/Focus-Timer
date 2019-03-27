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
    @IBOutlet weak var timeLabel: UILabel!
    
    private var buttonState = ButtonState.stop
    private var timer: Timer!
    private var timerSeconds = 25 * 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeLabel.text = TimeParser.stringTime(from: timerSeconds)
    }

    @IBAction func startStopButtonPressed(_ sender: Any) {
        if buttonState == .stop {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerUpdate(_:)), userInfo: nil, repeats: true)
            startStopButton.setImage(UIImage(named: "stop"), for: .normal)
            buttonState = .play
        } else {
            buttonState = .stop
            startStopButton.setImage(UIImage(named: "play"), for: .normal)
        }
    }
    
    @objc func timerUpdate(_ timer: Timer) {
        if buttonState == .stop {
            timer.invalidate()
        }
        
        timerSeconds = timerSeconds - 1
        timeLabel.text = TimeParser.stringTime(from: timerSeconds)
    }
    
}

