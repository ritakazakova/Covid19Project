import Foundation
import UIKit
import NotificationCenter

class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    
    func notification() {
        let notificationCenter = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
            }
        }
        
        notificationCenter.getNotificationSettings { (settings) in
          if settings.authorizationStatus != .authorized {
            // Notifications not allowed
          }
        }
    }
    
    
    func userNotificationCenter(
        _ notificationCenter: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void) {
        print(response)
    }
    
    func scheduleNotification(notificationType: String) {
        
        let content = UNMutableNotificationContent() // Содержимое уведомления
        
        content.title = "Notification"
        content.body = "This is example how to create "
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: "notification-ID",
            content: content,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in print(error) })
    }
    
}

