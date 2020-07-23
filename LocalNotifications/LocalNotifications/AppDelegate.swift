//
//  AppDelegate.swift
//  LocalNotifications
//
//  Created by Sergey Titov on 7/14/20.
//  Copyright © 2020 Sergey Titov. All rights reserved.
//

import UIKit
import UserNotifications


@UIApplicationMain



class AppDelegate: UIResponder, UIApplicationDelegate {
  
    let delegat =  ConfigNotification()
    
    let notificationCenter =  UNUserNotificationCenter.current()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { [weak self] (granted, error) in
            guard granted else {return}
            
            self?.notificationCenter.getNotificationSettings  {  settings in
            guard settings.authorizationStatus == .authorized else { return }
            }
        }
        
        notificationCenter.delegate = self
        return true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([ .sound, .alert, .badge ])
        
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
      
        switch response.actionIdentifier {
        case UNNotificationDefaultActionIdentifier:
            print("Default action")
        case UNNotificationDismissActionIdentifier:
            print("Dismiss action")
        case "cancel" :
            
            notificationCenter.removePendingNotificationRequests(withIdentifiers: ["notification"])
            print("Pressed Cancel")
            
        case "postpone" :
            
            delegat.configNotif()
            print("Pressed Postpone")
            
        default:
        
            print("default")
        }
        
        completionHandler()
    }
}
