//
//  Business.swift
//  DrinkLink
//
//  Created by Rebecca Shu on 3/19/22.
//

import Foundation

struct Coordinates: Codable {
    let latitude: Double
    let longitude: Double
}

enum Price: String, Codable {
    case low = "$"
    case medium = "$$"
    case high = "$$$"
    case veryHigh = "$$$$"
}

enum Transactions: String, Codable {
    case pickup
    case delivery
    case reservation = "restaurant_reservation"
}

struct Address: Codable {
    let city: String
    let country: String
    let state: String
    let street: String
    let zip: String
    
    enum CodingKeys: String, CodingKey {
        case city, country, state
        case street = "address1"
        case zip = "zip_code"
    }
}

struct Business: Codable, Identifiable {
    let id: String
    let name: String
    let url: String
    let coordinates: Coordinates
    let imageURL: String
    let address: Address
    let transactions: [Transactions]?
    let rating: Double
    let price: Price?
    let phone: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, url, coordinates, rating, phone, price, transactions
        case imageURL = "image_url"
        case address = "location"
    }
    
    var searchableString: String {
        "\(name)".lowercased()
    }
}
