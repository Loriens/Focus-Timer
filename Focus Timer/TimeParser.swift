//
//  TimeParser.swift
//  Focus Timer
//
//  Created by Vladislav on 28/03/2019.
//  Copyright © 2019 Vladislav Markov. All rights reserved.
//

import Foundation

class TimeParser {
    
    /// - parameter from: count of seconds
    /// - returns: formatted time "Minutes:Seconds"
    static func stringTime(from: Int) -> String {
        var minutes: Int,
            seconds: Int
        seconds = from % 60
        minutes = (from - seconds) / 60
        
        return "\(minutes):\(seconds)"
    }
    
}
