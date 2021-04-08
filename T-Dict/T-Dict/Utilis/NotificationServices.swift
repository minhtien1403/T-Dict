//
//  NotificationServices.swift
//  T-Dict
//
//  Created by Tiến on 4/6/21.
//  Copyright © 2021 Tiến. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
import Then

class NotificationServices: NSObject, UNUserNotificationCenterDelegate {
    
    private override init() {}
    
    static let shared = NotificationServices()
    
    private let notificationCenter = UNUserNotificationCenter.current()
    
    private let hour = 7
    
    private let minutes = 30
    
    var deniedPermission: (() -> Void)?
    
    func authorizeNotification() {
        let option: UNAuthorizationOptions = [.alert, .sound, .badge]
        notificationCenter.requestAuthorization(options: option) {[weak self] (success, _) in
            if !success {
                self?.deniedPermission?()
            }
        }
        notificationCenter.delegate = self
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    func setNofication(times: Int) {
        for index in 0..<times {
            let content = UNMutableNotificationContent()
            var dateComponent = DateComponents()
            dateComponent.hour = hour + index
            dateComponent.minute = minutes
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
            let request = UNNotificationRequest(identifier: UUID().uuidString,
                                                content: content.getContent,
                                                trigger: trigger)
            notificationCenter.add(request)
        }
    }
    
    func removePendingNotification() {
        notificationCenter.removeAllPendingNotificationRequests()
    }
    
}

extension UNMutableNotificationContent {
    var getContent: UNNotificationContent {
        return UNMutableNotificationContent().then {
            $0.title = AppSetting.searchHistory.randomElement() ?? "Nil"
            $0.body = "Click here to see details"
            $0.sound = .default
        }
    }
}
