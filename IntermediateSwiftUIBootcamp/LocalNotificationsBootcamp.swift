//
//  LocalNotificationsBootcamp.swift
//  IntermediateSwiftUIBootcamp
//
//  Created by Heimdal Data on 09.04.2025.
//

import SwiftUI
import UserNotifications
import CoreLocation

/* 3 Types of Notification Trigger
 - time based
 - calendar based
 - location based
 */

class NotificationManager {
    
    static let instance = NotificationManager() // Singleton
    
    func requestPermission() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("Error: \(error)")
            } else {
                print("Success")
            }
        }
    }
    
    func scheduleNotification() {
        
        // Notification Content
        let content = UNMutableNotificationContent()
        content.title = "Notification Title!"
        content.subtitle = "Notification Subtitle.."
        content.sound = .default
        content.badge = 1
        
        // Time Trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)   // Triggers 5s after requested
        
        // Calendar Trigger
//        var dateComponents = DateComponents()
//        dateComponents.hour = 12
//        dateComponents.minute = 00
//        dateComponents.weekday = 1 // Sunday
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)  // Repeats each day at 12:00
//        
        // Location Trigger
//        let coordinates = CLLocationCoordinate2D(
//            latitude: 50.00,
//            longitude: 40.00)
//        
//        let region = CLCircularRegion(
//            center: coordinates,
//            radius: 100,
//            identifier: UUID().uuidString)
//        region.notifyOnEntry = true  // Notifies when user enters region within the radius of 100m
//        region.notifyOnExit = false
//        
//        
//        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
//        
        // Request
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        
    }
    
    func cancelNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}

struct LocalNotificationsBootcamp: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Request Permission") {
                NotificationManager.instance.requestPermission()
            }
            
            Button("Schedule Notification") {
                NotificationManager.instance.scheduleNotification()
            }
            Button("Cancel Notification") {
                NotificationManager.instance.cancelNotifications()
            }
        }
        .onAppear {
            if #available(iOS 17.0, *) {
                UNUserNotificationCenter.current().setBadgeCount(0) { error in
                    if let error = error {
                        print("failed to reset badge count: \(error.localizedDescription)")
                    } else {
                        print("badge reset to 0")
                    }
                }
            } else {
                UIApplication.shared.applicationIconBadgeNumber = 0
            }
        }
    }
}

#Preview {
    LocalNotificationsBootcamp()
}
