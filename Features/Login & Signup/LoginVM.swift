//
//  LoginVM.swift
//  DrinkLink
//
//  Created by Yume Choi on 3/17/22.
//

import Combine
import SwiftUI

class LoginVM: ObservableObject {
    let dataStore: DataStore
    //@Published var newprofile: Profile
   //@Published var addedToList: Bool = false
    private var cancellables: Set<AnyCancellable> = []
    //@Published var profileId: UUID
    @Published var allProfiles: [Profile] = []
    @Published var state: State = .loading
    @Published var profile: Profile = Profile(name: "Loading", lastname: "Loading", username: "Loading", password: "Loading", me: true, photoUrl: nil)
    
    enum State {
        case loading
        case loaded
    }
    
    
    init(dataStore: DataStore) {
        self.dataStore = dataStore
        //self.profile = profile
        //self.newprofile = newprofile
        
        dataStore.$profiles
            .sink { [weak self] profileUpdate in
                self?.allProfiles = profileUpdate
                //self?.profile.append(newprofile)
            }.store(in: &cancellables)
    }
     
    /*
    init(dataStore: DataStore, profileId: UUID) {
        self.dataStore = dataStore
        self.profileId = profileId
        
        self.state = .loading
        dataStore.$profiles
            .sink{ [weak self] storeProfiles in
              self?.allProfiles = storeProfiles
                if let profile = storeProfiles.filter({ $0.id == self?.profileId }).first {
                    self?.profile = profile
                    self?.state = .loaded
                }
            }
            .store(in: &cancellables)
    }
    */
    


    
    /*
     
     func toggleLastPreparedAt() {
       if recipe.lastPreparedAt != nil {
         recipe.lastPreparedAt = nil
       } else {
         recipe.lastPreparedAt = Date.now
       }
       saveRecipe()
     }

     */
}
