//
//  DrinkLinkApp.swift
//  Shared
//ProfileList(viewModel: LoginVM(dataStore: dataStore))
//.environmentObject(dataStore)
//  Created by Yume Choi on 3/17/22.
//

import SwiftUI

@main
struct DrinkLinkApp: App {
    let dataStore = DataStore()
    let identityService = IdentityService()
    var newprofile: Profile = Profile(name: "Loading", lastname: "Loading", username: "Loading", password: "Loading", me: true, photoUrl: nil)

    var body: some Scene {
        WindowGroup {
            //ProfileList(viewModel: LoginVM(dataStore: dataStore))
                //.environmentObject(dataStore)
            LoginView(viewModel: LoginVM(dataStore: dataStore))
                .environmentObject(dataStore)
        }
    }
}
