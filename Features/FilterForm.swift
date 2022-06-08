//
//  FilterForm.swift
//  DrinkLink
//
//  Created by Rebecca Shu on 4/10/22.
//

import SwiftUI

struct FilterForm: View {
    @StateObject var viewModel: BusinessListVM
    let profile: Profile
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Text("What do you want to search for?")
                    .bold()
                    .font(.custom("Georgia-Bold", size: 24))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                //                    .padding(.top, -100)
                Picker("Scale Value", selection: $viewModel.filter, content: {
                    ForEach(FilterBusiness.FilterBusiness.allCases, content: { value in
                        Text(value.rawValue)
                            .bold()
                            .font(.custom("Georgia-Bold", size: 24))
                            .fontWeight(.semibold)
                        
                    })
                })
            }
            .padding(.top, -100)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Text("")
                        NavigationLink(destination: BusinessScreen(viewModel: viewModel, profile: profile)) {
                            Text("Done")
                        }
                    }
                }
            }
        }
    }
}

