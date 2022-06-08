//
//  TabContainer.swift
//  DrinkLink
//
//  Created by Rebecca Shu on 3/19/22.
//

import SwiftUI

enum Tab {
    case map
    case feed
    case profile
}

struct TabContainer: View {
    @EnvironmentObject var dataStore: DataStore
    @State var selectedTab: Tab = .profile
    //    @StateObject var viewModel: LoginVM
    let profile: Profile
    
    var body: some View {
        Group {
            TabView(selection: $selectedTab){
                
                ProfileDetail(viewModel: ProfileDetailVM(dataStore: dataStore, username: dataStore.currentUsername!, profileId: profile.id))
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                    .tabItem {
                        Label("Profile", systemImage: "person.circle")
                    }
                    .tag(Tab.profile)
                

                  Feed(viewModel: FeedVM(dataStore: dataStore, profileId: profile.id))
                  .navigationBarTitle("")
                  .navigationBarHidden(true)
                  .navigationBarBackButtonHidden(true)
                  .tabItem {
                      Label("Feed", systemImage: "person.2.circle")
                  }
                  .tag(Tab.feed)
                
                BusinessScreen(viewModel: BusinessListVM(apiService: YelpAPIService(), locationVM: LocationVM()), locationVM: LocationVM(), profile: profile)
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                    .tabItem {
                        Label("Businesses", systemImage: "mappin.circle")
                    }
                    .tag(Tab.map)
                
                
            }
        }
    }
}

//struct TabContainer_Previews: PreviewProvider {
//    let profile: Profile
//
//    static var previews: some View {
//        TabContainer(profile: profile)
//    }
//}
