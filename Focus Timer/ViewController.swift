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
    private var timer: Timer?
    private var breakTimer: Timer?
    private var mainBreakTimerSeconds = 5
    private var breakTimerSeconds: Int!
    private var mainTimerSeconds = 10
    private var timerSeconds: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        breakTimerSeconds = mainBreakTimerSeconds
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
            setAndStartBreakTimerSeconds()
            return
        }
        
        timerSeconds = timerSeconds - 1
        timeLabel.text = TimeParser.stringTime(from: timerSeconds)
    }
    
    @objc func breakTimerUpdate(_ timer: Timer) {
        if buttonState == .stop || breakTimerSeconds == 1 {
            timer.invalidate()
            setMainTimerSeconds()
            return
        }
        
        breakTimerSeconds = breakTimerSeconds - 1
        timeLabel.text = TimeParser.stringTime(from: breakTimerSeconds)
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
        timeLabel.textColor = UIColor(named: "baseColor")
        startStopButton.setImage(UIImage(named: "play"), for: .normal)
    }
    
    private func setAndStartBreakTimerSeconds() {
        breakTimerSeconds = mainBreakTimerSeconds
        timeLabel.text = TimeParser.stringTime(from: breakTimerSeconds)
        startStopButton.setImage(UIImage(named: "black stop"), for: .normal)
        timeLabel.textColor = UIColor.black
        
        breakTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(breakTimerUpdate(_:)), userInfo: nil, repeats: true)
    }
    
}

