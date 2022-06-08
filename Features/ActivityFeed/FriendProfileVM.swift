//
//  FriendProfileVM.swift
//  DrinkLink
//
//  Created by Yuna Kim on 4/11/22.
//

import Foundation

class FriendProfileVM: ObservableObject {
  
  @Published var friend: Profile
  
  init(friend: Profile) {
    self.friend = friend
  }
  
}
