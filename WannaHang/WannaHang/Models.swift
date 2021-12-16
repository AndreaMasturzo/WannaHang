import SwiftUI
import Contacts

struct QuickSelectionElement: View {
    var quickSelectionImage: String
    var body: some View {
        Image(quickSelectionImage)
            .resizable()
            .frame(width: 90, height: 90)
            .padding(.leading, 13)
    }
}

struct ContactInfo: Identifiable {
    var id = UUID()
    var firstName: String
    var lastName: String
    var phoneNumber: CNPhoneNumber?
}
