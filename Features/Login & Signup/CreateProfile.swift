//
//  CreateProfile.swift
//  DrinkLink
//
//  Created by Yume Choi on 4/8/22.
//

import SwiftUI

struct createProfile: View {
    
    @State private var firstname = ""
    @State private var lastname = ""
    @State private var username = ""
    @State private var password = ""
    @State private var confirmpassword = ""
    @State private var picture = ""
    @EnvironmentObject var dataStore: DataStore
    //@Environment(\.presentationMode) var presentationMode
    @SwiftUI.Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @ObservedObject var viewModel: LoginVM
    //@State var profiles = Profile.Data
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("What is your name?")) {
                    TextField("First Name",
                              text: $firstname)
                    TextField("Last Name",
                              text: $lastname)
                }
                Section(header: Text("Create a username and password!")) {
                    TextField("Username",
                              text: $username)
                    SecureField("Password", text: $password)
                    SecureField("Confirm Password", text: $confirmpassword)
                    
                }
                Section(header: Text("Add a profile picture!")) {
                    TextField("Picture", text: $picture)
                        .keyboardType(.URL)
                        .textContentType(.URL)
                }
                if (password == confirmpassword) && (password != "") {
                    Button(action: {
                        let newprofile: Profile = Profile(name: firstname, lastname: lastname, username: username.lowercased(), password: password, me: true, photoUrl: URL(string: picture))
                        //dataStore.newprofile = newprofile
                        //dataStore.newprofile.append(newprofile)
                        //dataStore.currentUsername = username
                        //print(dataStore.profiles)
                        //viewModel.addButtonTapped(newprofile)
                        dataStore.addProfile(newprofile)
                        presentationMode.wrappedValue.dismiss()
                        
                    }, label: {
                        Text("Done!")})
                }
                else {
                    Text("Passwords don't match!")
                        .foregroundColor(Color.red)
                }
            } .navigationBarTitle(Text("Create Profile"))
        }
    }
}
