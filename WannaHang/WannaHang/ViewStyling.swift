
import SwiftUI

struct MainButton: View {
    var topText: String
    var bottomText: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 145)
                .frame(width: 300, height: 300, alignment: .center)
            VStack(spacing: 0) {
                Text(topText)
                    .font(.system(size: 70))
                    .bold()
                    .foregroundColor(Color(red: 120/255, green: 120/255, blue: 128/255, opacity: 0.5))
                Image(bottomText)
                    .resizable()
                    .frame(width: 170, height: 65)
                    .padding(.leading)
                    .padding(.bottom)
            }
            
            .foregroundColor(.white)
        }
    }
}

struct MainButton1: View {
    var topText1: String
    var bottomText1: String
    var timeText: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 145)
                .frame(width: 300, height: 300, alignment: .center)
            VStack(spacing: 0) {
                Text(topText1)
                    .font(.system(size: 60))
                    .bold()
                    .foregroundColor(Color(red: 120/255, green: 120/255, blue: 128/255, opacity: 0.5))
                Image(bottomText1)
                    .resizable()
                    .frame(width: 160, height: 50)
                    .foregroundColor(Color(red: 120/255, green: 120/255, blue: 128/255))
                    .padding(.leading)
                    .padding(.bottom)
                Text(timeText)
                    .font(.system(size: 20))
                    .foregroundColor(Color(red: 117/255, green: 129/255, blue: 132/255, opacity: 0.4))
                    .padding(.top, -2.0)
                    .padding(.bottom)
            }
            
            .foregroundColor(.white)
        }
    }
}

struct Background: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(Color(red: 222/255, green: 253/255, blue: 255/255))
            .frame(width: 400, height: 890)
    }
}


struct buttonConfig: View {
    var text = ""
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 300, height: 60)
                .shadow(color: Color(red: 120/255, green: 120/255, blue: 128/255), radius: 2, x: 2, y: 2)
            Text(text)
                .foregroundColor(Color(red: 120/255, green: 120/255, blue: 128/255, opacity: 1))
        }
    }
}

func formatTime() {
    var timeFormatter : DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none

        return formatter
    }
}
