
import SwiftUI
import UserNotifications

struct ContentView: View {
    @AppStorage("onboarding") var onboarding = false
    @StateObject private var notificationManager = NotificationManager()
    @State private var time = Date.now
    @State private var withTime = false
    @State private var newSheet = false
    @State private var secondSheet = false
    @State private var alert = false
    @State private var opacity = 0
    
    
    var body: some View {

        NavigationView {
            VStack {
                Spacer()
                VStack(spacing: -45) {
                    Image("QuestionMark")
                    
                    if !withTime {
                        Button(action: {
                            /// To show the alert when the button is pressed
                          //  alert.toggle()
                            /// To open ContactsView
                            newSheet.toggle()
                            
                            /// To create a local notification 5 sec after the button is pressed
                            let content = UNMutableNotificationContent()
                            content.title = "Wanna Hang?"
                            content.subtitle = "It's time to hang! Have a nice time! ☺️"
                            content.sound = UNNotificationSound.default

                            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 30, repeats: false)
                            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                            UNUserNotificationCenter.current().add(request)
                        }, label: {
                            MainButton(topText: "Wanna", bottomText: "Hang?")
                                .foregroundColor(Color(red: 195/255, green: 232/255, blue: 235/255))
                        })
                    } else {
                        Button(action: {
                            
                            secondSheet.toggle()
                           

                            
                            
                            /// To create a notification shown on the time selected
                            let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: time)
                            guard let hour = dateComponents.hour, let minute = dateComponents.minute else {return }
                            notificationManager.createLocalNotification(title: "Wanna Hang?", subtitle: "It's \(time.formatted(date: .omitted, time: .shortened))! Time to hang! 🎉", hour: hour, minute: minute) { error in
                                if error == nil {
                                    DispatchQueue.main.async {
                                        self.newSheet = false
                                    }
                                }
                            }
                        }, label: {
                            ZStack {
                                MainButton1(topText1: "Wanna", bottomText1: "Hang?", timeText: "@\(time.formatted(date: .omitted, time: .shortened))")
                                    .foregroundColor(Color(red: 195/255, green: 232/255, blue: 235/255))
                            }
                        })
                    }
                }
                
                Toggle(isOn: $withTime, label: {
                    HStack {
                        Text("Time")
                            .foregroundColor(Color(red: 117/255, green: 129/255, blue: 132/255))
                            .padding(.leading)
                        Spacer()
                        if withTime == true {
                            DatePicker("Select The Time", selection: $time, displayedComponents: .hourAndMinute)
                                .labelsHidden()
                                .padding(.leading, 18.0)
                        }
                        Spacer()
                    }
                })
                    .tint(.blue)
                    .sheet(isPresented: $onboarding, content: {Onboarding(onboarding: $onboarding)})
                    .sheet(isPresented: $newSheet) {
                        Contacts(shown: $newSheet)
                    }
                    .sheet(isPresented: $secondSheet) {
                        Contacts2(atTime: $time, isShown: $secondSheet)
                    }
                    .padding()
                    .padding(.trailing)
                    .padding(.bottom, 150)
                Spacer()
            }
            .background((Color(red: 222/255, green: 253/255, blue: 255/255)))
        }
        .onAppear {
            notificationManager.reloadAuthorizationsStatus()
        }
        .onChange(of: notificationManager.authorizationStatus) { authorizationStatus in
            switch authorizationStatus {
            case .notDetermined:
                notificationManager.requestAuthorization()
                
            case .authorized:
                notificationManager.reloadLocalNotifications()
            default:
                break
            
            }
        }
        .onDisappear {
            notificationManager.reloadLocalNotifications()
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
