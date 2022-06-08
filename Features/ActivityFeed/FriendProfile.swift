//
//  FriendProfile.swift
//  DrinkLink
//
//  Created by Yuna Kim on 4/11/22.
//

import Foundation
import SwiftUI

struct FriendProfile: View {
    @ObservedObject var viewModel: FriendProfileVM
    
    func initialize() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading) {
               // let newprofile: Profile = Profile(name: "Loading", lastname: "Loading", username: "Loading", password: "Loading", me: true, photoUrl: nil)
                
                
                HStack(alignment: .center) {
                    Spacer()
                    AsyncImage(url: viewModel.friend.photoUrl) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        
                    } placeholder: {
                        if viewModel.friend.photoUrl != nil {
                            Image(systemName: "person.fill")
                        }
                    } .frame(maxWidth: 150, maxHeight: 150)
                    //RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color.pink.opacity(0.4))
                        .background(
                            RoundedRectangle(cornerRadius: 50, style: .continuous).fill(Color("DrinkLinkColor")))
                    Spacer()
                    VStack {
                      Text(viewModel.friend.name + " " + viewModel.friend.lastname)
                            .font(.custom("Georgia", size: 35))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        VStack {
                            Text("Friends:")
                                .font(.custom("Georgia", size: 20))
                                .fontWeight(.bold)
                          Text(String(viewModel.friend.friends.count))
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
                
              Text(viewModel.friend.name + "'s" + " Drinks")
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
                
                List(viewModel.friend.drinks) { drink in
                    VStack(alignment: .leading) {
                        Text("Drink: " + drink.name)
                            .font(.headline)
                        Text("From: " + drink.venue)
                            .font(.caption2)
                        Text("Rating: " + String(drink.rating ?? 0) + "/5")
                    }
                    .listRowBackground(Color.pink.opacity(0.3))
                }.frame(minHeight: 300)
                .onAppear {
                    self.initialize()
                }
            }
            
        }
        .accentColor(Color.white)
        .background(Color("DrinkLinkColor"))
    }
}

