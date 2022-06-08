//
//  YelpAPIService.swift
//  DrinkLink
//
//  Created by Rebecca Shu on 3/19/22.
//

import Foundation

class YelpAPIService: ObservableObject {
    
    func fetchBusinesses(latitude: Double, longitude: Double, searchTerm: String) async throws -> BusinessSearchResponse {
        let apikey = "v8MLWJUGJewFmaSI5Wtb0QcyrFSCeJ9fgQKA06SJaY5pxLzNb4cMdngS7IrDagOjERFmd4LacFeN7Yoy5CiKFwt5c_PuEwK6899dw1hxD0WCYsxCoDEPHNsQiUYxYnYx"
        
        guard let url = URL(string: YelpEndpoint.path(latitude: latitude, longitude: longitude, searchTerm: searchTerm)) else {throw APIError.invalidResponse}
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        //        urlRequest.setValue("application/json", forHTTPHeaderField:"Content-Type")
        urlRequest.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
        
        let response: BusinessSearchResponse = try await RestAPIClient().performRequest(urlRequest: urlRequest)
        return response
    }
}

