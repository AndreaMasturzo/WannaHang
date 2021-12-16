import SwiftUI
import UserNotifications

class MessageMenager {

    static func sendMessageWithTime(at number: String, with message: String, and time: Date = Date.now) {
        let sms: String = "sms:(number)&body=(message) @(time.formatted(date: .omitted, time: .shortened))?"
        let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
    }


    static func sendMessage(at number: String, with message: String) {
        let sms: String = "sms:(number)&body=(message)?"
        let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
    }
}
