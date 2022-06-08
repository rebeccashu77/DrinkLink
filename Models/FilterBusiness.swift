//
//  FilterBusiness.swift
//  DrinkLink
//
//  Created by Rebecca Shu on 4/10/22.
//

import Foundation

struct FilterBusiness {
    var filterBusiness: FilterBusiness
    
    enum FilterBusiness: String, CaseIterable, Identifiable {
        case wine = "Wine"
        case tea = "Tea"
        case smoothies = "Smoothies"
        case coffee = "Coffee"
        case boba = "Boba"
        case beer = "Beer"
        case drink = "Drinks"
        
        var id: Self { self }
    }
}
