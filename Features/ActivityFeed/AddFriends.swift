//
//  AddFriendsForm.swift
//  DrinkLink
//
//  Created by Yuna Kim on 4/10/22.
//

import SwiftUI

struct AddFriends: View {
    @ObservedObject var viewModel: FeedVM
    
    var body: some View {
      NavigationView {
        List(viewModel.filteredUsers) { user in
          UserRow(viewModel: viewModel, user: user)
                .listRowBackground(Color.pink.opacity(0.3))
        }
      }
      .searchable(text: $viewModel.searchText)
    }
}

struct UserRow: View {
  @ObservedObject var viewModel: FeedVM
  let user: Profile
  
  var body: some View {
    HStack {
      AsyncImage(url: user.photoUrl) { image in
        image
          .resizable()
          .aspectRatio(contentMode: .fit)
      } placeholder: {
        if user.photoUrl != nil {
          ProgressView()
        } else {
          Image(systemName: "person.fill")
        }
      }
      .frame(maxWidth: 100, maxHeight: 100)
      Text(user.name)
      Spacer()
      Button { viewModel.addOrRemoveFriend(user: user) }
    label: {Text(viewModel.ButtonText(user: user))
        .font(.caption2)
    }
      .padding(5)
      .background(Color({viewModel.ButtonColor(user:user)}()))
      .clipShape(Capsule())
    }
  }
}

