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
    
    var delegate: UIViewController?
    
    init() {
        requestAuth()
    }
    
    private func requestAuth() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) {
            success, error in
            
            if success {
                self.configureNotification()
            }
        }
    }
    
    private func configureNotification() {
        let category = UNNotificationCategory(identifier: "timer", actions: [], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
    
    private func createNotification(with text: String) {
        let content = UNMutableNotificationContent()
        
        content.title = text
        content.categoryIdentifier = "timer"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "timerIsDone", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
}
