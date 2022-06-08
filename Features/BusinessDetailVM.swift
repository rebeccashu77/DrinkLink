//
//  BusinessDetailVM.swift
//  DrinkLink
//
//  Created by Rebecca Shu on 3/19/22.
//

import Foundation
import Combine
import Accessibility

class BusinessDetailVM: ObservableObject {
  
  private var dataStore: DataStore
  private var cancellables: Set<AnyCancellable> = []
  
  @Published var drink = Drink(name: "Loading", venue: "Loading")
  @Published var formData: Drink.FormData = Drink.FormData(name: "", venue: "", rating: 3)
  
  var profileId: UUID
  @Published var profile: Profile = Profile(name: "Loading", lastname: "Loading", username: "Loading", password: "Loading", me: true, photoUrl: nil)
    
  let apiService: YelpAPIService
  @Published var business: Business
  @Published var addSheetIsPresenting: Bool = false
    
  init(dataStore: DataStore, apiService: YelpAPIService, business: Business, profileId: UUID) {
    self.dataStore = dataStore
    self.apiService = apiService
    self.business = business
    self.profileId = profileId
    self.formData.venue = business.name
    
    dataStore.$profiles
        .sink{ [weak self] storeProfiles in
            if let profile = storeProfiles.filter({ $0.username == dataStore.currentUsername }).first {
                self?.profile = profile
            }
        }
        .store(in: &cancellables)
    
  }
    
  func addButtonTapped() {
      self.addSheetIsPresenting = (self.addSheetIsPresenting == true ? false : true)
  }
  
  func dismissForm() {
    self.addSheetIsPresenting = false
  }
  
  func save() {
    let newDrink = Drink.create(drink, from: formData)
    dataStore.createDrink(newDrink)
    dataStore.addDrinktoUser(profile, drink: newDrink)
    self.dismissForm()
  }
  
}

