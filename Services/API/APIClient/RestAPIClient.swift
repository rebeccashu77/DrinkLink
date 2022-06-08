//
//  RestAPIClient.swift
//  DrinkLink
//
//  Created by Rebecca Shu on 3/19/22.
//

import Foundation

struct RestAPIClient<Response: Decodable>: APIClient {
    let session: URLSession = .shared
    
    func performRequest(urlRequest: URLRequest) async throws -> Response {
        let response: Response = try await perform(request: urlRequest)
        return response
        
    }
    
    
}
