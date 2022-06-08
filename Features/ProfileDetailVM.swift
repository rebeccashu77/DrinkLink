//
//  ProfileDetailVM.swift
//  DrinkLink
//
//  Created by Yume Choi on 3/17/22.
//

import Foundation
import SwiftUI
import Combine

final class ProfileDetailVM: ObservableObject {
    enum State {
        case loading
        case loaded
    }
    
    private var dataStore: DataStore
    private var cancellables: Set<AnyCancellable> = []
    var username: String
    var profileId: UUID
    
    @Published var state: State = .loading
    @Published var profile: Profile = Profile(name: "Loading", lastname: "Loading", username: "Loading", password: "Loading", me: true, photoUrl: nil)
    
    init(dataStore: DataStore, username: String, profileId: UUID) {
        self.dataStore = dataStore
        self.username = username
        self.profileId = profileId
        
        self.state = .loading
        
        dataStore.$currentUsername
            .sink { [weak self] newUsername in
                if let newUsername = newUsername,
                let profile = self?.dataStore.fetchProfile(username: newUsername) {
                    self?.profile = profile
                    self?.state = .loaded
                }
                
            }.store(in: &cancellables)
         
        
        dataStore.$profiles
            .sink { [weak self] storeProfiles in
                if let profile = storeProfiles.filter({ $0.username == dataStore.currentUsername }).first {
                    self?.profile = profile
                    self?.state = .loaded
                }
            }.store(in: &cancellables)
         
        
    }
        
  func saveProfile() {
        dataStore.updateProfile(profile)
  }
  
  var numberOfFriends: Int {
    return profile.friends.count
  }
    
    func deleteDrink(_ drink: Drink) {
        dataStore.deleteDrink(profile, drink)
    }
}
