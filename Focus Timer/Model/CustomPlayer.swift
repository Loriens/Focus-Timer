//
//  CustomPlayer.swift
//  Focus Timer
//
//  Created by Vladislav on 29/03/2019.
//  Copyright © 2019 Vladislav Markov. All rights reserved.
//

import AVFoundation

class CustomPlayer {
    
    /// If ID is zero, there is no sound
    private var systemSoundID: Int!
    
    init() {
        systemSoundID = 0
    }
    
    init(soundID: Int) {
        systemSoundID = soundID
    }
    
    func play() {
        if systemSoundID != 0 {
            AudioServicesPlaySystemSound(SystemSoundID(systemSoundID))
        }
    }
    
    func changeSound(soundID: Int) {
        systemSoundID = soundID
    }
    
    func clearSound() {
        systemSoundID = nil
    }
    
}
