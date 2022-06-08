//
//  FeedVM.swift
//  DrinkLink
//
//  Created by Yuna Kim on 3/21/22.
//

import Foundation
import Combine
import SwiftUI

class FeedVM: ObservableObject {
  enum State {
      case loading
      case loaded
  }
  
  private var dataStore: DataStore
  private var cancellables: Set<AnyCancellable> = []
  var profileId: UUID
  
  @Published var state: State = .loading
  @Published var profile: Profile = Profile(name: "Loading", lastname: "Loading", username: "Loading", password: "Loading", me: true, photoUrl: nil)
  @Published var allProfiles: [Profile] = []
  @Published var addSheetIsPresenting: Bool = false
  
  @Published var searchText = ""
  
  @Published var friendStatus: Bool = false
  
  var filteredUsers: [Profile] {
    if searchText.isEmpty {
      let modifiedProfiles = allProfiles.filter { $0.id != profile.id }
        return modifiedProfiles
        //return dataStore.profiles
    } else {
      return allProfiles
        .filter { $0.name.lowercased().contains(searchText.lowercased())}
    }
  }
  
  init(dataStore: DataStore, profileId: UUID) {
      self.dataStore = dataStore
      self.profileId = profileId
      
      self.state = .loading
      
      dataStore.$profiles
          .sink{ [weak self] storeProfiles in
            self?.allProfiles = storeProfiles
              if let profile = storeProfiles.filter({ $0.username == dataStore.currentUsername }).first {
                  self?.profile = profile
                  self?.state = .loaded
              }
          }
          .store(in: &cancellables)
  }
  
  func addButtonTapped() {
      self.addSheetIsPresenting = (self.addSheetIsPresenting == true ? false : true)
  }
  
  func inFriendList(user: Profile) -> Bool {
    if profile.friends.contains(user) {
      return true
    }
    else {
      return false
    }
  }
  
  func addOrRemoveFriend(user: Profile) {
    if inFriendList(user: user) {
      dataStore.removeFriend(profile, user: user)
    } else {
      dataStore.addFriend(profile, user: user)
    }
  }
  
  func ButtonText(user: Profile) -> String {
    if inFriendList(user: user) {
      return "Remove Friend"
    } else {
      return "Add Friend"
    }
  }
  
  func ButtonColor(user: Profile) -> String {
    if inFriendList(user: user) {
      return "RemoveFriendsButton"
    } else {
      return "AddFriendsButton"
    }
  }
}
