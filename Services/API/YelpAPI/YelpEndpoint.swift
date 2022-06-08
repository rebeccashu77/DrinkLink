//
//  YelpEndpoint.swift
//  DrinkLink
//
//  Created by Rebecca Shu on 3/19/22.
//

import Foundation
//import NetworkClient

struct YelpEndpoint {
//  static let baseUrl = "https://api.yelp.com/v3/businesses/search?term=drink"
    static let baseUrl = "https://api.yelp.com/v3/businesses/search?term="

    static func path(latitude: Double, longitude: Double, searchTerm: String) -> String {
      let url = "\(baseUrl)"
//        let queryParameters = "latitude=\(latitude)&longitude=\(longitude)"
        let queryParameters = "\(searchTerm)&latitude=\(latitude)&longitude=\(longitude)"
//        let queryParameters = "latitude=36.0014859&longitude=-78.9340742"
      return "\(url)\(queryParameters)"
    }
}

