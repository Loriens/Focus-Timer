//
//  ViewController.swift
//  Focus Timer
//
//  Created by Vladislav on 27/03/2019.
//  Copyright © 2019 Vladislav Markov. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    private var buttonState = ButtonState.stop
    private var timer: Timer?
    private var breakTimer: Timer?
    // FIX: change time
    private var mainBreakTimerSeconds = 5
    private var breakTimerSeconds: Int!
    // FIX: change time
    private var mainTimerSeconds = 10
    private var timerSeconds: Int!
    private var player: CustomPlayer!
    /// Number of element in Const.sounds
    private var soundNumber: Int = 0
    private var startDateMainTimer: Date?
    private var startDateBreakTimer: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        soundNumber = UserDefaults.standard.integer(forKey: Key.soundNumber.rawValue)
        if soundNumber == 0 {
            player = CustomPlayer()
        } else {
            player = CustomPlayer(soundID: soundNumber)
        }
        
        if let workingTime = UserDefaults.standard.object(forKey: Key.workingTime.rawValue) as? Int {
            mainTimerSeconds = workingTime
        }
        
        if let breakingTime = UserDefaults.standard.object(forKey: Key.breakingTime.rawValue) as? Int {
            mainBreakTimerSeconds = breakingTime
        }
        
        breakTimerSeconds = mainBreakTimerSeconds
        setMainTimerSeconds()
        
        NotificationCenter.default.addObserver(self, selector: #selector(userDefaultsValueChanged(_:)), name: UserDefaults.didChangeNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        <#code#>
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
            player.play()
            return
        }
        
        timerSeconds = timerSeconds - 1
        updateTime(seconds: timerSeconds)
    }
    
    @objc func breakTimerUpdate(_ timer: Timer) {
        if buttonState == .stop || breakTimerSeconds == 1 {
            timer.invalidate()
            setMainTimerSeconds()
            if breakTimerSeconds == 1 {
                player.play()
            }
            return
        }
        
        breakTimerSeconds = breakTimerSeconds - 1
        updateTime(seconds: breakTimerSeconds)
    }
    
    private func toggleButtonStartStop() {
        if buttonState == .stop {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerUpdate(_:)), userInfo: nil, repeats: true)
            startStopButton.setImage(UIImage(named: "stop"), for: .normal)
            buttonState = .play
        } else {
            buttonState = .stop
            setMainTimerSeconds()
        }
    }
    
    private func setMainTimerSeconds() {
        timerSeconds = mainTimerSeconds
        timeLabel.text = TimeParser.stringTime(from: timerSeconds)
        startStopButton.setImage(UIImage(named: "play"), for: .normal)
    }
    
    private func setAndStartBreakTimerSeconds() {
        breakTimerSeconds = mainBreakTimerSeconds
        timeLabel.text = TimeParser.stringTime(from: breakTimerSeconds)
        startStopButton.setImage(UIImage(named: "black stop"), for: .normal)
        
        breakTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(breakTimerUpdate(_:)), userInfo: nil, repeats: true)
    }
    
    @objc func userDefaultsValueChanged(_ sender: Any?) {
        if let workingTime = UserDefaults.standard.object(forKey: Key.workingTime.rawValue) as? Int {
            mainTimerSeconds = workingTime
            setMainTimerSeconds()
        }
        
        if let breakingTime = UserDefaults.standard.object(forKey: Key.breakingTime.rawValue) as? Int {
            breakTimerSeconds = breakingTime
        }
        
        let soundNumber = UserDefaults.standard.integer(forKey: Key.soundNumber.rawValue)
        player.changeSound(soundID: Const.sounds[soundNumber].1)
    }
    
    func updateTime(seconds: Int) {
        timeLabel.text = TimeParser.stringTime(from: seconds)
    }
    
}

