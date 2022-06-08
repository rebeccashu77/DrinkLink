//
//  Profile.swift
//  DrinkLink
//
//  Created by Yume Choi on 3/17/22.
//

import Foundation

struct Profile: Hashable, Identifiable {
  static func == (lhs: Profile, rhs: Profile) -> Bool {
    return lhs.id == rhs.id
  }
  
    let id: UUID = UUID()
    var name: String
    var lastname: String
    var username: String
    var password: String
    var me: Bool
    var photoUrl: URL?
    var friends: [Profile] = []
    var drinks: [Drink] = []
}

extension Profile {
    static var Data = [
        Profile(name: "Yume", lastname: "Choi",  username: "yumechoi", password: "goduke", me: false,
                photoUrl: URL(string:"https://education-jrp.s3.amazonaws.com/RoommateImages/Rachel.png")!),
        Profile(name: "Yuna", lastname: "Kim", username: "yunakim", password: "goduke", me: false,
                photoUrl: URL(string:"https://education-jrp.s3.amazonaws.com/RoommateImages/Monica.png")!),
        Profile(name: "Rebecca", lastname: "Shu", username: "rebeccashu", password: "goduke", me: false,
                photoUrl: URL(string:"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbN23w1oDIVZZRsDTuEnHcc4ybGczzoT9UeQ&usqp=CAU")!)
        
    ]
}
