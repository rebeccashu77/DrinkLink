//
//  BusinessList.swift
//  DrinkLink
//
//  Created by Rebecca Shu on 3/19/22.
//

import SwiftUI
import MapKit

struct BusinessScreen: View {
    @StateObject var viewModel: BusinessListVM
    @StateObject var locationVM = LocationVM()
    let profile: Profile
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .notAvailable:
                Text("Cannot reach API")
            case .failed:
                Text("Error")
            case .success:
                //                BusinessList(viewModel: viewModel, locationVM: locationVM)
                //                MapView(viewModel: viewModel, locationVM: locationVM)
              MapView(viewModel: viewModel, profile: profile)
            }
        }
        .task { await viewModel.getBusinesses() }
        .alert("Error", isPresented: $viewModel.hasAPIError, presenting: viewModel.state) { detail in
            Button("Retry") {
                Task { await viewModel.getBusinesses() }
            }
            Button("Cancel") {}
        }
    message: { detail in
        if case let .failed(error) = detail {
            Text(error.localizedDescription)
        }
    }
    }
}

struct MapView: View {
    @ObservedObject var viewModel: BusinessListVM
    @StateObject var locationVM = LocationVM()
    let profile: Profile
    
    @State var tracking: MapUserTrackingMode = .follow
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    viewModel.addButtonTapped()
                }) {
                    Text(viewModel.filter.rawValue)
                }
                .padding(.trailing, 15)
                .padding(.top, -20)
                .background(.white)
            }
            .frame(height: 20)
            .sheet(isPresented: $viewModel.addSheetIsPresenting) {
                FilterForm(viewModel: viewModel, profile: profile)
                    .interactiveDismissDisabled()
            }
            
                
            Map(coordinateRegion: $locationVM.region,
                interactionModes: MapInteractionModes.all,
                showsUserLocation: true,
                userTrackingMode: $tracking,
                annotationItems: viewModel.businesses) { business in
                //                MapMarker(coordinate: CLLocationCoordinate2D(latitude: business.coordinates.latitude, longitude: business.coordinates.longitude))
                
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: business.coordinates.latitude, longitude: business.coordinates.longitude)) {
                    LocationAnnotation(viewModel: viewModel, selectedLocation: business) }
            }
                .overlay(
                    Group {
                        if let tappedLocation = viewModel.tappedLocation {
                          SelectedLocationPopUp(viewModel: viewModel, selectedLocation: tappedLocation, profile: profile)
                        }
                    }
                )
                .ignoresSafeArea()
                .refreshable {
                    await viewModel.getBusinesses()
                }
        }
        .padding(.bottom)
    }
}

struct SelectedLocationPopUp: View {
  @ObservedObject var viewModel: BusinessListVM
  @EnvironmentObject var dataStore: DataStore
  let selectedLocation: Business
  let profile: Profile
    
    var body: some View {
        VStack {
            Button("Close") {
                viewModel.tappedLocation = nil }
            .padding(.bottom, 10)
//            .font(.custom("Georgia-Bold", size: 20))
            
            Text(selectedLocation.name)
                .font(.custom("Georgia-Bold", size: 30))
                .fontWeight(.bold)
                .foregroundColor(Color("DrinkLinkColor"))
                .padding(.bottom, 10)
                .multilineTextAlignment(.center)
            
            NavigationLink(destination: BusinessDetail(
              viewModel: BusinessDetailVM(dataStore: dataStore, apiService: YelpAPIService(), business: selectedLocation, profileId: profile.id)))
            {
                Text("View")
//                    .font(.custom("Georgia-Bold", size: 20))
            }
            
        }
        .padding(50)
        .background(Rectangle().foregroundColor(.white))
    }
}

struct LocationAnnotation: View {
    @ObservedObject var viewModel: BusinessListVM
    let selectedLocation: Business
    
    var body: some View {
        Image(systemName: "mappin")
            .padding()
            .foregroundColor(.red)
            .font(.title)
            .onTapGesture {
                viewModel.tappedLocation = selectedLocation
            }
    }
}

//// switched this to map view
//struct BusinessList: View {
//    @ObservedObject var viewModel: BusinessListVM
//    @ObservedObject var locationVM: LocationVM
//
//    var body: some View {
//        NavigationView {
//            List(viewModel.filteredBusinesses) { business in NavigationLink(destination: BusinessDetail(
//              viewModel: BusinessDetailVM( apiService: YelpAPIService(), business: business)))
//                {
//                    BusinessRow(business: business)
//                }
//                .navigationBarTitle("")
//                .navigationBarHidden(true)
//
//            }
//            .padding(.top)
//            .padding(.bottom)
//            //            .navigationBarTitle("")
//            //            .navigationBarHidden(true)
//            //            .navigationBarBackButtonHidden(true)
//            .navigationTitle("Businesses").listStyle(.plain)
//            .background(Color("DrinkLinkColor"))
//            .searchable(text: $viewModel.searchText)
//
//        }
//        .padding(.top, -225)
//    }
//}

////switched this to map view
//struct BusinessRow: View {
//    let business: Business
//    
//    var body: some View {
//        HStack {
//            // business image
//            AsyncImage(url: URL(string: business.imageURL)) { image in
//                image
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//            } placeholder: {
//                ProgressView()
//            }
//            .frame(maxWidth: 100, maxHeight: 100)
//            
//            // business information
//            VStack(alignment: .leading) {
//                // business name
//                Text(business.name).font(.headline)
//                    .fixedSize(horizontal: false, vertical: true)
//                Text(business.address.street)
//                Text(business.address.city + ", " + business.address.state + " " + business.address.zip)
//                Spacer()
//            }
//        }
//    }
//}

//struct BusinessList_Previews: PreviewProvider {
//    static var previews: some View {
//        BusinessList(viewModel: BusinessListVM(apiService: YelpAPIService(), locationVM: LocationVM()), locationVM: LocationVM())
//    }
//}

