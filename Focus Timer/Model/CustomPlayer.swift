//
//  CustomPlayer.swift
//  Focus Timer
//
//  Created by Vladislav on 29/03/2019.
//  Copyright © 2019 Vladislav Markov. All rights reserved.
//

import AVFoundation

class CustomPlayer {
    
    private var systemSoundID: Int?
    
    init() { }
    
    init(soundID: Int) {
        systemSoundID = soundID
    }
    
    func play() {
        if let sound = systemSoundID {
            AudioServicesPlaySystemSound(SystemSoundID(sound))
        }
    }
    
    func changeSound(soundID: Int) {
        systemSoundID = soundID
    }
    
    func clearSound() {
        systemSoundID = nil
    }
    
}
