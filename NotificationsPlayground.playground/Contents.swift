//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/// Our own type to use in place of `Notification.Name`
typealias AppNotificationName = Notification.Name

/// A protocol to define notifications that are sent around with our `NotificationCenter` extension functionality
protocol AppNotification {

    /// The type must be defined a `Notification`
    associatedtype Payload

    /// The name for the notification (for registration and posting).
    /// It's recommended to use the `defaultName()` function, to give it a simple base value.
    static var name: AppNotificationName { get }

    /// A payload to send in a notification. It is sent through `Notification`'s the `object` property
    var payload: Payload { get }
}

extension NotificationCenter {

    /// This function posts notifications, using a generic parameter tailored to `AppNotification`s.
    ///
    /// - Parameter appNotification: The appNotification to post.
    static func post<T>(appNotification: T) where T: AppNotification {
        let notification = Notification(name: T.name, object: appNotification.payload)
        NotificationCenter.default.post(notification)
    }

    /// This function registers notifications, tailored to the `AppNotification` type.
    ///
    /// - Parameters:
    ///   - name: The AppNotification to register.
    ///   - observer: An observer to use for calling the target selector.
    ///   - selector: The selector to call the observer with.
    static func register(name: AppNotificationName, observer: Any, selector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: name, object: nil)
    }
}

extension Notification {

    /// This function allows you to pull a payload out of a `Notification`, with the result being
    /// typed to the defined `Payload` type.
    ///
    /// - Parameter notificationType: The notificationType to retrieve the payload from.
    /// - Returns: The payload from the AppNotification.
    func getPayload<T>(notificationType: T.Type) -> T.Payload? where T: AppNotification {
        return self.object as? T.Payload
    }
}

extension AppNotification {

    static var name: Notification.Name {
        return Notification.Name(String(describing: self))
    }
}





