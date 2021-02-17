import Foundation
import UIKit
import NotificationCenter

class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    func notification() {
        
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        notificationCenter.requestAuthorization(options: options) { granted, error in
            if (granted) {
                
            }
        }
        
        notificationCenter.delegate = self
    }
    
    
    func scheduleNotification() {
        
        let content = UNMutableNotificationContent() // Содержимое уведомления
        content.categoryIdentifier = "category-go-to-details"
        content.title = "Covid19Progect"
        content.body = "Would you like to read news about Covid19?"
        content.sound = UNNotificationSound.default
        
        
        var dateComponents = DateComponents()
        dateComponents.hour = 14
        dateComponents.minute = 04
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        
        let request = UNNotificationRequest(
            identifier: "notification-ID",
            content: content,
            trigger: trigger
        )
        
        notificationCenter.add(request)
        
        let action = UNNotificationAction(
            identifier: "action-ID",
            title: "Of course!",
            options: [.foreground]
        )
        
        let category = UNNotificationCategory(
            identifier: "category-go-to-details",
            actions: [action],
            intentIdentifiers: [],
            options: []
        )
        
        self.notificationCenter.setNotificationCategories([category])
    }
    
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
        }
    
}

