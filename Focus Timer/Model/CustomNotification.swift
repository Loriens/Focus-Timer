//
//  CustomNotification.swift
//  Focus Timer
//
//  Created by Vladislav on 29/03/2019.
//  Copyright © 2019 Vladislav Markov. All rights reserved.
//

import UIKit
import UserNotifications

class CustomNotification {
    
    private var identifier = "Custom Timer"
    
    /// - parameter title: if is nil, then it is a simple request to allow notifications. Else the function creates a notification with the title.
    func requestAuth(with title: String? =  nil, secondsInterval seconds: Int = 1) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) {
            success, error in
            
            if success && title != nil {
                self.configureNotification()
                self.createNotification(with: title!, seconds: seconds)
            }
        }
    }
    
    private func configureNotification() {
        let category = UNNotificationCategory(identifier: "timer", actions: [], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
    
    private func createNotification(with text: String, seconds: Int) {
        let content = UNMutableNotificationContent()
        
        content.title = text
        content.categoryIdentifier = "timer"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(seconds), repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    func cancel() {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
}
