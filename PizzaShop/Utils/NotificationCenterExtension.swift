//
//  NotificationCenterExtension.swift
//  PizzaShop
//
//  Created by Arman Abkar on 9/8/21.
//

import UIKit
import UserNotifications

extension NotificationCenter {
    static func createNotification(title: String, body: String, date: Date, from vc: UIViewController) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.sound = .default
        content.body = body
        
        let targetDate = date
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate), repeats: false)
        
        let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if error != nil {
                UIAlertController.showAlert(message: "Something Went Wrong...", from: vc)
            }
        }
    }
}
