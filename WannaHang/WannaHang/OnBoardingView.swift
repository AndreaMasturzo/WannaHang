import SwiftUI

public struct OnboardingElement: View {
    
    public var titleText: String
    public var image: Image
    public var subtitleText: String
    
    public var body: some View {
        
        HStack {
            image
                .foregroundColor(Color(red: 120/255, green: 120/255, blue: 128/255, opacity: 0.5))
                .font(.system(size: 60))
            VStack {
                Text(titleText)
                    .foregroundColor(Color(red: 120/255, green: 120/255, blue: 128/255))
                    .font(.custom("SF Pro", size: 25))
                    .bold()
                    .frame(width: 250, alignment: .leading)
                Text(subtitleText)
                    .foregroundColor(Color(red: 120/255, green: 120/255, blue: 128/255))
                    .frame(width: 250, alignment: .leading)
            }
            .multilineTextAlignment(.leading)
            .padding(.bottom)
        }
    }
}

struct Onboarding: View {
    
    @Binding var onboarding: Bool
    
    var body: some View {
       
        GeometryReader {geo in
            VStack {
                VStack {
                    /// View Title
                    Text("Welcome to")
                        .font(.system(size: 45))
                        .bold()
                    
                    Text("Wanna  Hang?")
                        .font(.system(size: 45))
                        .bold()
                }
                .foregroundColor(Color(red: 120/255, green: 120/255, blue: 128/255))
                .multilineTextAlignment(.center)
                .padding(.top, 130)
                
                /// Composition of elements
                VStack(spacing: 35) {
                    OnboardingElement(titleText: "Message", image: Image(systemName: "arrow.up.message.fill"), subtitleText: "Create sendable invitations with just one tap")
                    
                    OnboardingElement(titleText: "Time", image: Image(systemName: "clock.fill"), subtitleText: "Add a time to your hang-out event")
                    
                    OnboardingElement(titleText: "Reminder", image: Image(systemName: "bell.badge.circle.fill"), subtitleText: "Get a reminder to know when it's time to hang out")
                    
                    OnboardingElement(titleText: "Share", image: Image(systemName: "person.2.circle.fill"), subtitleText: "Share the message to anyone in your contact list")
                }
                .frame(width: 350, height: 530, alignment: .center)
                .padding(.bottom)
                .padding(.top, -20)
                /// Button at the bottom of the screen
                Button(action: {onboarding.toggle()}, label: {
                    buttonConfig(text: "Continue")
                        .foregroundColor(Color(red: 195/255, green: 232/255, blue: 235/255))
                })
                    
                Spacer()
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .ignoresSafeArea()
            .background((Color(red: 222/255, green: 253/255, blue: 255/255)))
        }
    }
}


struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding(onboarding: .constant(false))
    }
}
