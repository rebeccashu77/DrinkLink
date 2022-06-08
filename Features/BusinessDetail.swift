//
//  BusinessDetail.swift
//  DrinkLink
//
//  Created by Rebecca Shu on 3/19/22.
//

import SwiftUI

struct BusinessDetail: View {
    @StateObject var viewModel: BusinessDetailVM
    @EnvironmentObject var dataStore: DataStore
    
    var body: some View {
        ZStack {
            // background color
            Color("DrinkLinkColor").ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .center) {
                    Text(viewModel.business.name)
                        .font(.custom("Georgia-Bold", size: 30))
                        .fontWeight(.bold)
                        .padding(.bottom, 20)
                        .foregroundColor(.white)
                    
                    //business immage
                    BusinessImageView(viewModel: viewModel)
                    
                    Text(viewModel.business.address.street)
                        .font(.custom("Georgia-Bold", size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text(viewModel.business.address.city + ", " + viewModel.business.address.state + " " + viewModel.business.address.zip)
                        .font(.custom("Georgia-Bold", size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    if let p = viewModel.business.phone {
                        Text("Phone: " + p)
                            .font(.custom("Georgia-Bold", size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    if let price = viewModel.business.price?.rawValue {
                        Text(price)
                            .font(.custom("Georgia-Bold", size: 20))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                .toolbar {
                    //edit sheet
                    ToolbarItem(placement: .navigationBarTrailing) { Button("Add Drink") {
                        viewModel.addButtonTapped() }}
                }
                .sheet(isPresented: $viewModel.addSheetIsPresenting) {
                    AddForm(viewModel: viewModel)
                }
//                .padding(50)
            }
        }
    }
}

struct BusinessImageView: View {
    @StateObject var viewModel: BusinessDetailVM
    
    var body: some View {
        AsyncImage(url: URL(string: viewModel.business.imageURL)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(6.0)
        } placeholder: {
            ProgressView()
        }
        .frame(maxWidth: 300, maxHeight: 300)
//        .background(
//            RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color.pink.opacity(0.3)))
    }
}


struct BusinessDetail_Previews: PreviewProvider {
    //    var b = Business(id: "123", name: "Sazon", url: "duke.com", coordinates: Coordinates(latitude: 0.0, longitude: 0.0), imageURL: "www.duke.com", address: Address(city: "Durham", country: "USA", state: "NC", street: "409 towerview", zip: "27708"), transactions: [], rating: 5, price: Price.low, phone: "5136020055")
    //    static let viewModel = BusinessDetailVM(apiService: YelpAPIService(), business: b)
    static var previews: some View {
      BusinessDetail(viewModel: BusinessDetailVM(dataStore: DataStore(), apiService: YelpAPIService(), business: Business(id: "123", name: "Sazon", url: "duke.com", coordinates: Coordinates(latitude: 0.0, longitude: 0.0), imageURL: "www.duke.com", address: Address(city: "Durham", country: "USA", state: "NC", street: "409 towerview", zip: "27708"), transactions: [], rating: 5, price: Price.low, phone: "5136020055"), profileId: UUID()))
    }
}
