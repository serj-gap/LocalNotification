//
//  ConfigNotification.swift
//  LocalNotifications
//
//  Created by Sergey Titov on 7/24/20.
//  Copyright © 2020 Sergey Titov. All rights reserved.
//

import Foundation
import NotificationCenter


class ConfigNotification {
    
    func configNotif() {
        
        let notificationCenter =  UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
                   content.sound = UNNotificationSound.default
                   content.body = "Good Morning"
                   content.title = "WakeUP"
    
        let postpone = UNNotificationAction(identifier: "postpone", title: "Postpone", options: .foreground)
        
            let deleteAction = UNNotificationAction(identifier: "cancel", title: "Cancel", options: .destructive)
        
            let notificationCategory = UNNotificationCategory(identifier: "notificationCategory", actions: [postpone, deleteAction], intentIdentifiers: [], options: [])
            
            UNUserNotificationCenter.current().setNotificationCategories([notificationCategory])
            content.categoryIdentifier = "notificationCategory"
        
        
        
        let triger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: triger)
        notificationCenter.add(request, withCompletionHandler: nil)
    }    
}
