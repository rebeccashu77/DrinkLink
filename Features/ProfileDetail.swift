//
//  ProfileDetail.swift
//  DrinkLink
//
//  Created by Yume Choi on 3/17/22.
//
// identityService, get the Current username
import Foundation
import SwiftUI

struct ProfileDetail: View {
    @StateObject var viewModel: ProfileDetailVM
    @EnvironmentObject var dataStore: DataStore
    
    func initialize() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        
        ScrollView {
            switch viewModel.state {
            case .loading: ProgressView()
            case .loaded:
                VStack(alignment: .leading) {
                   // let newprofile: Profile = Profile(name: "Loading", lastname: "Loading", username: "Loading", password: "Loading", me: true, photoUrl: nil)
                    
                    ZStack {
                        NavigationLink("Logout", destination: LoginView(viewModel: LoginVM(dataStore: dataStore))
                                        .environmentObject(dataStore))
                            .font(.custom("Georgia", size: 15))
                            .foregroundColor(.white)
                            .frame(width: 70, height: 30)
                            .background(Color.red.opacity(0.7))
                            .cornerRadius(5.0)
                    }
                    .padding(.leading, 20)

                    
                    HStack(alignment: .center) {
                        Spacer()
                        AsyncImage(url: viewModel.profile.photoUrl) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            
                        } placeholder: {
                            if viewModel.profile.photoUrl != nil {
                                Image(systemName: "person.fill")
                            }
                        } .frame(maxWidth: 150, maxHeight: 150)
                        //RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color.pink.opacity(0.4))
                            .background(
                                RoundedRectangle(cornerRadius: 50, style: .continuous).fill(Color("DrinkLinkColor")))
                        Spacer()
                        VStack {
                            Text(viewModel.profile.name)
                                .font(.custom("Georgia", size: 40))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Text(viewModel.profile.lastname)
                                .font(.custom("Georgia", size: 40))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            VStack {
                                Text("Friends:")
                                    .font(.custom("Georgia", size: 20))
                                    .fontWeight(.bold)
                                Text(String(viewModel.numberOfFriends))
                                    .font(.custom("Georgia", size: 20))
                                    .fontWeight(.bold)
                            }
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 6, style: .continuous).fill(Color.white))
                            .overlay(
                                RoundedRectangle(cornerRadius: 6, style: .continuous)
                                    .strokeBorder(Color.black, lineWidth: 3)
                            )
                        }
                        Spacer()
                    }
                    .padding()
                    
                    Text("My Drinks")
                        .font(.custom("Georgia", size: 20))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                    
//                    ForEach(viewModel.profile.drinks) { drink in
//                        VStack(alignment: .leading) {
//                            Text("Drink: " + drink.name)
//                                .font(.headline)
//                            Text("From: " + drink.venue)
//                                .font(.caption2)
//                            Text("Rating: " + String(drink.rating ?? 0) + "/5")
//                        }
//                        .padding()
//                    }
                    
                    List(viewModel.profile.drinks) { drink in
                        VStack(alignment: .leading) {
                            Text("Drink: " + drink.name)
                                .font(.headline)
                            Text("From: " + drink.venue)
                                .font(.caption2)
                            Text("Rating: " + String(drink.rating ?? 0) + "/5")
                        }
                        .listRowBackground(Color.pink.opacity(0.3))

                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                viewModel.deleteDrink(drink)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }.frame(minHeight: 300)
                    .onAppear {
                        self.initialize()
                    }
                }
                
            }
        } .accentColor(Color.white)
            .background(Color("DrinkLinkColor"))
    }
}

