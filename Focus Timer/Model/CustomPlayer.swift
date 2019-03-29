//
//  CustomPlayer.swift
//  Focus Timer
//
//  Created by Vladislav on 29/03/2019.
//  Copyright © 2019 Vladislav Markov. All rights reserved.
//

import AVFoundation

class CustomPlayer {
    
    private var audioPlayer: AVAudioPlayer!
    private var systemSoundID: Int
    
    init() {
        systemSoundID = 1000
    }
    
    init(soundID: Int) {
        systemSoundID = soundID
    }
    
    func play() {
        AudioServicesPlaySystemSound(SystemSoundID(systemSoundID))
    }
    
    func changeSound(soundID: Int) {
        systemSoundID = soundID
    }
    
}
