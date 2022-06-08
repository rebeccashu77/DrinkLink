//
//  BusinessSearchResponse.swift
//  DrinkLink
//
//  Created by Rebecca Shu on 3/19/22.
//

import Foundation

struct BusinessSearchResponse: Codable {
    let total: UInt
    let businesses: [Business]
}
