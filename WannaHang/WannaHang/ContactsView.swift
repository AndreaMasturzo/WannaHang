

import SwiftUI
import Contacts

struct ContactRow: View {
    
    @State var tapped = false
    var contact: ContactInfo
    
    
    var body: some View {
            Button (action: {
                tapped.toggle()
                MessageMenager.sendMessage(at: "\(contact.phoneNumber!.stringValue)", with: "Wanna Hang")
            }, label: {
                HStack {
                Text("\(contact.firstName) \(contact.lastName)").foregroundColor(.primary)
                    Spacer()
                tapped ? Image(systemName: "checkmark.circle.fill").foregroundColor(.blue) : Image(systemName: "checkmark.circle").foregroundColor(.blue)
                }
            })
    }
}

struct ContactRow2: View {
    @Binding var atTime: Date
    @State var tapped = false
    var contact: ContactInfo
    
    
    var body: some View {
            Button (action: {
                tapped.toggle()
                MessageMenager.sendMessageWithTime(at: "\(contact.phoneNumber!.stringValue)", with: "Wanna Hang", and: atTime)
            }, label: {
                HStack {
                Text("\(contact.firstName) \(contact.lastName)").foregroundColor(.primary)
                    Spacer()
                tapped ? Image(systemName: "checkmark.circle.fill").foregroundColor(.blue) : Image(systemName: "checkmark.circle").foregroundColor(.blue)
                }
            })
    }
}


/// To force the resigning of the keyboard on end editing
extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct Contacts: View {
    
    @State var tapped = false
    @Binding var shown: Bool
    @State var contacts = [ContactInfo.init(firstName: "", lastName: "", phoneNumber: nil)]
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false

    
    func getContacts() {
        DispatchQueue.main.async {
            contacts = FetchContacts().fetchingContacts()
        }
    }
    
    func requestAccess() {
        let store = CNContactStore()
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            self.getContacts()
        case .denied:
            store.requestAccess(for: .contacts) { granted, error in
                if granted {
                    self.getContacts()
                }
            }
        case .restricted, .notDetermined:
            store.requestAccess(for: .contacts) { granted, error in
                if granted {
                    self.getContacts()
                }
            }
        @unknown default:
            print("error")
        }
    }
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    HStack {
                        /// search bar magnifying glass image
                        Image(systemName: "magnifyingglass").foregroundColor(.secondary)
                        
                        /// search bar text field
                        TextField("search", text: self.$searchText, onEditingChanged: { isEditing in
                            self.showCancelButton = true
                        })
                        
                        /// x Button
                        Button(action: {
                            self.searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.secondary)
                                .opacity(self.searchText == "" ? 0 : 1)
                        }
                    }
                    .padding(8)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                }
                .padding([.leading, .trailing,.top])
                List {
                    ForEach (self.contacts.filter({ (cont) -> Bool in
                        self.searchText.isEmpty ? true :
                        "\(cont)".lowercased().contains(self.searchText.lowercased())
                    })) { contact in
                        ContactRow(contact: contact)
                    }
                }.onAppear() {
                    self.requestAccess()
                }
                .toolbar {
                    ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                        Button(action: {
                            shown.toggle()
                        }, label: {
                            Text("Cancel")
                                .foregroundColor(.red)
                        })
                    }
                    
                    ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                        Button(action: {
                            shown.toggle()
                        }, label: {
                            Text("Save")
                        })
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


struct Contacts2: View {
    @Binding var atTime: Date
    @State var tapped = false
    @Binding var isShown: Bool
    @State var contacts = [ContactInfo.init(firstName: "", lastName: "", phoneNumber: nil)]
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false

    
    func getContacts() {
        DispatchQueue.main.async {
            contacts = FetchContacts().fetchingContacts()
        }
    }
    
    func requestAccess() {
        let store = CNContactStore()
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            self.getContacts()
        case .denied:
            store.requestAccess(for: .contacts) { granted, error in
                if granted {
                    self.getContacts()
                }
            }
        case .restricted, .notDetermined:
            store.requestAccess(for: .contacts) { granted, error in
                if granted {
                    self.getContacts()
                }
            }
        @unknown default:
            print("error")
        }
    }
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    HStack {
                        /// search bar magnifying glass image
                        Image(systemName: "magnifyingglass").foregroundColor(.secondary)
                        
                        /// search bar text field
                        TextField("search", text: self.$searchText, onEditingChanged: { isEditing in
                            self.showCancelButton = true
                        })
                        
                        /// x Button
                        Button(action: {
                            self.searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.secondary)
                                .opacity(self.searchText == "" ? 0 : 1)
                        }
                    }
                    .padding(8)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                }
                .padding([.leading, .trailing,.top])
                List {
                    ForEach (self.contacts.filter({ (cont) -> Bool in
                        self.searchText.isEmpty ? true :
                        "\(cont)".lowercased().contains(self.searchText.lowercased())
                    })) { contact in
                        ContactRow2(atTime: $atTime, contact: contact)
                    }
                }.onAppear() {
                    self.requestAccess()
                }
                .toolbar {
                    ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                        Button(action: {
                            isShown.toggle()
                        }, label: {
                            Text("Cancel")
                                .foregroundColor(.red)
                        })
                    }
                    
                    ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                        Button(action: {
                            isShown.toggle()
                        }, label: {
                            Text("Save")
                        })
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}





struct Contacts_Previews: PreviewProvider {
    static var previews: some View {
        Contacts(shown: .constant(false))
    }
}
