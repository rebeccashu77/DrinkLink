//
//  CreateProfileVM.swift
//  DrinkLink
//
//  Created by Yume Choi on 4/9/22.
//

import Foundation
import Combine

class CreateProfileVM: ObservableObject {
    let dataStore: DataStore
    @Published var newprofile: Profile
    @Published var addedToList: Bool = false
    private var cancellables: Set<AnyCancellable> = []
    @Published var profileList: [Profile] = []
    
    init(dataStore: DataStore, newprofile: Profile) {
        self.dataStore = dataStore
        //self.profile = profile
        self.newprofile = newprofile
        
        dataStore.$profiles
            .sink { [weak self] profileUpdate in
                if !(profileUpdate.contains(where: { $0.username == self?.newprofile.username} )) {
                    self?.profileList.append(newprofile)
                    self?.dataStore.profiles.append(newprofile)
                    dataStore.addProfile(newprofile)
                    self?.addedToList = true
                    //self?.addButtonTapped(newprofile)
                }
                else {
                    self?.addedToList = false
                }
               
            }.store(in: &cancellables)
    }
    
    func addButtonTapped(_ profile: Profile) {
        addedToList = (addedToList ? false : true)
        newprofile = profile
        if addedToList == true {
            dataStore.addProfile(profile)
        }
    }

}
