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
        var minutes: String,
            seconds: String
        seconds = "\(from % 60)"
        let intSeconds = from % 60
        minutes = "\((from - intSeconds) / 60)"
        
        return minutes.addZeroIfNeed() + ":" + seconds.addZeroIfNeed()
    }
    
}

extension String {
    /// Add zero if number less than 10
    func addZeroIfNeed() -> String {
        let intNumber = Int(self)
        
        guard let unwrappedIntNumber = intNumber else {
            return self
        }
        
        return (unwrappedIntNumber < 10) ? "0\(self)" : self
    }
}
