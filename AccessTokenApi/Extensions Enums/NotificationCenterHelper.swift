//
//  NotificationCenterHelper.swift
//  AccessTokenApi
//
//  Created by Mert Atakan on 7.09.2023.
//

import Foundation

final class NotificationCenterManager {
    
    static let shared = NotificationCenterManager()

    private init() {}

    func postNotification(name: Notification.Name) {
        NotificationCenter.default.post(name: name, object: nil)
    }

    func addObserver(observer:Any, name: Notification.Name, selector:Selector) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: name, object: nil)
    }

    func removeObserver(observer:Any) {
        NotificationCenter.default.removeObserver(observer)
    }
}


