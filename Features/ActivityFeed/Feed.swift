//
//  Feed.swift
//  DrinkLink
//
//  Created by Yuna Kim on 3/21/22.
//

import Foundation
import SwiftUI

struct Feed: View {
  @StateObject var viewModel: FeedVM
  
  var body: some View {
    switch viewModel.state {
      case .loading: ProgressView()
      case .loaded:
      ZStack {
        Color("DrinkLinkColor")
          .ignoresSafeArea()
        ScrollView {
          HStack {
            Spacer()
            Button("Add Friends") {
            viewModel.addButtonTapped()
          }
            .padding(5)
            .background(Color.white)
            .clipShape(Capsule())
          }
          .padding()
          VStack {
            Text("Friends' Activities")
              .font(.custom("Georgia-Bold", size: 30))
              .fontWeight(.semibold)
              .padding(.bottom, 20)
              .foregroundColor(.white)
            ForEach(viewModel.profile.friends) { friend in
              VStack(alignment: .leading) {
                NavigationLink(destination: FriendProfile(viewModel: FriendProfileVM(friend: friend))) {
                  FriendRow(viewModel: viewModel, friend: friend)
                }
                .buttonStyle(PlainButtonStyle())
                Divider()
              }
            }
          }
          .sheet(isPresented: $viewModel.addSheetIsPresenting) {
              AddFriends(viewModel: viewModel)
          }
        }
      }
    }
  }
}

struct FriendRow: View {
  @ObservedObject var viewModel: FeedVM
  let friend: Profile
  
  var body: some View {
    HStack {
      AsyncImage(url: friend.photoUrl) { image in
        image
          .resizable()
          .aspectRatio(contentMode: .fit)
      } placeholder: {
        if friend.photoUrl != nil {
          ProgressView()
        } else {
          Image(systemName: "person.fill")
        }
      }
      .frame(maxWidth: 80, maxHeight: 80)
      Text(friend.name + " " + friend.lastname)
        .font(.custom("Georgia-Bold", size: 20))
    }
    .padding()
  }
}

struct Feed_Previews: PreviewProvider {
  static let dataStore = DataStore()
  static var previews: some View {
      Feed(viewModel: FeedVM(dataStore: dataStore, profileId: Profile.Data[0].id))
  }
}
