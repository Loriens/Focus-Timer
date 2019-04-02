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
    private var mainBreakTimerSeconds = 5 * 60
    private var breakTimerSeconds: Int!
    private var mainTimerSeconds = 25 * 60
    private var timerSeconds: Int!
    private var player: CustomPlayer!
    /// Number of element in Const.sounds
    private var soundNumber: Int = 0
    private var startDateMainTimer: Date?
    private var startDateBreakTimer: Date?
    // If there is a value, then breakTimer = mainBreakTimerSeconds - minusSeconds
    private var minusSeconds: Int?
    private var notification: CustomNotification!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notification = CustomNotification()
        notification.requestAuth()
        
        soundNumber = UserDefaults.standard.integer(forKey: Key.soundNumber.rawValue)
        if soundNumber == 0 {
            player = CustomPlayer()
        } else {
            player = CustomPlayer(soundID: Const.sounds[soundNumber].1)
        }
        
        if let workingTime = UserDefaults.standard.object(forKey: Key.workingTime.rawValue) as? Int {
            mainTimerSeconds = workingTime * 60
        }
        
        if let breakingTime = UserDefaults.standard.object(forKey: Key.breakingTime.rawValue) as? Int {
            mainBreakTimerSeconds = breakingTime * 60
        }
        
        breakTimerSeconds = mainBreakTimerSeconds
        setMainTimerSeconds()
        
        NotificationCenter.default.addObserver(self, selector: #selector(userDefaultsValueChanged(_:)), name: UserDefaults.didChangeNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTimerWhenAppBecomeActive(_:)), name: UIApplication.didBecomeActiveNotification, object: nil)
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
        } else if timerSeconds < 1 {
            timer.invalidate()
            setAndStartBreakTimerSeconds()
            return
        }
        
        timerSeconds = timerSeconds - 1
        updateTime(seconds: timerSeconds)
    }
    
    @objc func breakTimerUpdate(_ timer: Timer) {
        if buttonState == .stop || breakTimerSeconds <= 1 {
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
            startDateMainTimer = Date()
        } else {
            buttonState = .stop
            setMainTimerSeconds()
            startDateMainTimer = nil
            startDateBreakTimer = nil
            notification.cancel()
        }
    }
    
    private func setMainTimerSeconds() {
        notification.requestAuth(with: "Отдохни", secondsInterval: mainTimerSeconds)
        timerSeconds = mainTimerSeconds
        timeLabel.text = TimeParser.stringTime(from: timerSeconds)
        startStopButton.setImage(UIImage(named: "play"), for: .normal)
        buttonState = .stop
    }
    
    private func setAndStartBreakTimerSeconds() {
        notification.requestAuth(with: "Cфокусируйся на задаче", secondsInterval: mainBreakTimerSeconds)
        breakTimerSeconds = mainBreakTimerSeconds
        if let minus = minusSeconds {
            breakTimerSeconds = breakTimerSeconds - minus
        }
        timeLabel.text = TimeParser.stringTime(from: breakTimerSeconds)
        startStopButton.setImage(UIImage(named: "black stop"), for: .normal)
        
        startDateMainTimer = nil
        startDateBreakTimer = Date()
        breakTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(breakTimerUpdate(_:)), userInfo: nil, repeats: true)
    }
    
    func updateTime(seconds: Int) {
        timeLabel.text = TimeParser.stringTime(from: seconds)
    }
    
    @objc func userDefaultsValueChanged(_ sender: Any?) {
        if let workingTime = UserDefaults.standard.object(forKey: Key.workingTime.rawValue) as? Int {
            if workingTime * 60 != mainTimerSeconds {
                mainTimerSeconds = workingTime * 60
                setMainTimerSeconds()
            }
        }
        
        if let breakingTime = UserDefaults.standard.object(forKey: Key.breakingTime.rawValue) as? Int {
            if breakingTime * 60 != mainBreakTimerSeconds {
                mainBreakTimerSeconds = breakingTime * 60
                setMainTimerSeconds()
            }
        }
        
        let soundNumber = UserDefaults.standard.integer(forKey: Key.soundNumber.rawValue)
        player.changeSound(soundID: Const.sounds[soundNumber].1)
    }
    
    @objc func updateTimerWhenAppBecomeActive(_ sender: Any?) {
        if let startMainTimer = startDateMainTimer {
            let elapsed = Int(Date().timeIntervalSince(startMainTimer))
            if elapsed >= 1 {
                timerSeconds = mainTimerSeconds - elapsed
                if timerSeconds >= 1 {
                    updateTime(seconds: timerSeconds)
                } else {
                    minusSeconds = abs(timerSeconds)
                }
            }
        } else if let startBreakTimer = startDateBreakTimer {
            let elapsed = Int(Date().timeIntervalSince(startBreakTimer))
            
            if elapsed >= 1 {
                breakTimerSeconds = mainBreakTimerSeconds - elapsed
                if breakTimerSeconds >= 1 {
                    updateTime(seconds: breakTimerSeconds)
                }
            }
        }
    }
    
}

