//
//  ViewController.swift
//  LocalNotifications
//
//  Created by Sergey Titov on 7/14/20.
//  Copyright © 2020 Sergey Titov. All rights reserved.
//

import UIKit
import NotificationCenter


class ViewController: UIViewController {
       
    let picker = UIDatePicker()
        
    
    @IBOutlet weak var textTime: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textTime.inputView = configuratePicker()
        createToolBar()
    }

    
    func createToolBar() {
        let toolBar = UIToolbar()
            toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(setTime))
        let flexButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([flexButton, doneButton,flexButton], animated: true)
        textTime.inputAccessoryView = toolBar
        
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(tapGestDone))
        self.view.addGestureRecognizer(tapGest)
    }
    
    @objc func tapGestDone() {
        view.endEditing(true)
    }
    
    
    func timeFormat() {
        let formater = DateFormatter()
        formater.dateFormat = "HH:mm"
        textTime.text = formater.string(from: picker.date)
    
    }
   
    func configuratePicker () -> UIDatePicker {
        picker.preferredDatePickerStyle = .automatic
        picker.datePickerMode = .time
        return picker
    }

  @objc  func setTime() {
        
       timeFormat()
       view.endEditing(true)
        
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
                   
        let triggerDate = Calendar.current.dateComponents([ .hour, .minute ], from: picker.date )
        print(triggerDate)
        
        
        let triger = UNCalendarNotificationTrigger(dateMatching: triggerDate , repeats: true)
        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: triger)
        
            notificationCenter.add(request, withCompletionHandler: nil)
    }
  
}
   
    
    
    
    
    

