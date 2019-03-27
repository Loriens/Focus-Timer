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
    private var mainTimerSeconds = 10
    private var timerSeconds: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setMainTimerSeconds()
    }

    @IBAction func startStopButtonPressed(_ sender: Any) {
        toggleButtonStartStop()
    }
    
    @objc func timerUpdate(_ timer: Timer) {
        if buttonState == .stop {
            timer.invalidate()
            return
        } else if timerSeconds == 1 {
            timer.invalidate()
            toggleButtonStartStop()
            setMainTimerSeconds()
            return
        }
        
        timerSeconds = timerSeconds - 1
        timeLabel.text = TimeParser.stringTime(from: timerSeconds)
    }
    
    private func toggleButtonStartStop() {
        if buttonState == .stop {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerUpdate(_:)), userInfo: nil, repeats: true)
            startStopButton.setImage(UIImage(named: "stop"), for: .normal)
            buttonState = .play
        } else {
            buttonState = .stop
            startStopButton.setImage(UIImage(named: "play"), for: .normal)
        }
    }
    
    private func setMainTimerSeconds() {
        timerSeconds = mainTimerSeconds
        timeLabel.text = TimeParser.stringTime(from: timerSeconds)
    }
    
}

