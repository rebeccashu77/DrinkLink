//
//  Login.swift
//  DrinkLink
//
//  Created by Yume Choi on 3/17/22.
//
import SwiftUI

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

struct LoginView : View {
    @State var username_input: String = ""
    @State var password_input: String = ""
    
    @State var authenticationDidFail: Bool = false
    @State var authenticationDidSucceed: Bool = false
    
    @EnvironmentObject var dataStore: DataStore
    //@EnvironmentObject var identityService: IdentityService
    @StateObject var viewModel: LoginVM
    //@StateObject var viewModel_cp: CreateProfileVM
    @State var showingSheet = false
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Welcome to DrinkLink!")
                        .font(.custom("Georgia-Bold", size: 48))
                        .fontWeight(.semibold)
                        .padding(.bottom, 20)
                        .foregroundColor(.white)
                    UsernameTextField(username_input: $username_input)
                    PasswordSecureField(password_input: $password_input)
                    Button("New? Create Profile!") {
                        showingSheet.toggle()
                    }
                    .sheet(isPresented: $showingSheet) {
                        createProfile(viewModel:viewModel)
                    }
                    if let user = dataStore.profiles.filter({ $0.username == username_input.lowercased() }).first {
                        
                        NavigationLink(destination: TabContainer(dataStore: _dataStore, profile: user), isActive: self.$authenticationDidSucceed)  {
                            Button(action: {
                                if user.password == password_input {
                                    dataStore.currentUsername = user.username
                                    //dataStore.newprofile = user
                                    self.authenticationDidSucceed = true
                                    self.authenticationDidFail = false
                                }
                                else {
                                    self.authenticationDidFail = true
                                    self.authenticationDidSucceed = false
                                }
                                
                            }, label: {
                                Text("Login!")
                                    .font(.custom("Georgia", size: 20))
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(width: 220, height: 60)
                                    .background(Color.green.opacity(0.7))
                                    .cornerRadius(15.0)
                            })
                        }
                    }

                    if authenticationDidFail {
                        Text("Information not correct. Try again.")
                            .offset(y: -10)
                            .foregroundColor(.red)
                    }
                }
                .padding()
            }
            .padding()
            .background(Color("DrinkLinkColor"))
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        
    }
}

struct UsernameTextField : View {
    @Binding var username_input: String
    var body: some View {
        return TextField("Username", text: $username_input)
            .font(.custom("Georgia", size: 20))
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}

struct PasswordSecureField : View {
    
    @Binding var password_input: String
    
    var body: some View {
        return SecureField("Password", text: $password_input)
            .font(.custom("Georgia", size: 20))
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 20)
    }
}


struct LoginProfile: View {
    let profile: Profile
    
    @State var profiles = Profile.Data
    
    var body: some View {
        ScrollView {
            HStack {
                AsyncImage(url: profile.photoUrl)
                { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: { ProgressView() }
                .padding(10)
                Text(profile.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
            }.padding(10)
                .frame(maxHeight: 150, alignment: .top)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color("DrinkLinkColor"))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .strokeBorder(Color.white, lineWidth: 3)
                )
        }         .padding(.top)
    }
}
