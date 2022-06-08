//
//  BusinessListVM.swift
//  DrinkLink
//
//  Created by Rebecca Shu on 3/19/22.
//

import Foundation
import Combine
import MapKit

enum LoadingState {
  case notAvailable
  case loading
  case success
  case failed(error: Error)
}

@MainActor
class BusinessListVM: ObservableObject {
  let apiService: YelpAPIService
    let locationVM: LocationVM
  
  @Published private(set) var state: LoadingState = .notAvailable
  @Published var hasAPIError: Bool = false
  
  @Published var businesses: [Business] = []
    @Published var searchText: String = ""
//    @Published var region = MKCoordinateRegion()
    @Published var tappedLocation: Business?
    
    @Published var addSheetIsPresenting: Bool = false
    @Published var filter = FilterBusiness.FilterBusiness.drink

    var filteredBusinesses: [Business] {
      if searchText.isEmpty {
        return businesses
      } else {
        return businesses
          .filter { $0.searchableString.lowercased().contains(searchText.lowercased()) }
      }
    }

    init(apiService: YelpAPIService, locationVM: LocationVM) {
    self.apiService = apiService
      self.locationVM = locationVM
  }

    func getBusinesses() async {
    self.state = .loading
    do {
        let latitude = locationVM.userLatitude
        let longitude = locationVM.userLongitude
        let businesses = try await apiService.fetchBusinesses(latitude: latitude, longitude: longitude, searchTerm: filter.rawValue).businesses
      self.state = .success
        self.businesses = businesses
    } catch {
      self.state = .failed(error: error)
      self.hasAPIError = true
    }
  }
    
    func addButtonTapped() {
        self.addSheetIsPresenting = (self.addSheetIsPresenting == true ? false : true)
    }
  
}

