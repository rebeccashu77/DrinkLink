//
//  Drink.swift
//  DrinkLink
//
//  Created by Yuna Kim on 3/29/22.
//

import Foundation
import SwiftUI

struct Drink: Codable, Identifiable, Hashable {
  var id: UUID = UUID()
  var name: String
  var venue: String
  var rating: Int?
  var createdAt: Date?
  

  
  struct FormData {
    var name: String = ""
    var venue: String = ""
    var rating: Int = 3
  }
  
  var formData: FormData {
    FormData(
      name: name,
      venue: venue,
      rating: rating ?? 3
    )
  }
  
  static func create(_ drink: Drink, from formData: FormData) -> Drink {
    var drink = drink
    drink.name = formData.name
    drink.venue = formData.venue
    drink.rating = formData.rating
    drink.createdAt = Date()
    return drink
  }

  
}

extension Drink {
  static let previewData = [
    Drink(name: "Matcha Latte w/ Oat Milk", venue: "Duke Cafe", rating: 5)]
}
