//
//  AddForm.swift
//  DrinkLink
//
//  Created by Rebecca Shu on 3/20/22.
//

import SwiftUI

struct AddForm: View {
    @ObservedObject var viewModel: BusinessDetailVM
    
    var body: some View {
      NavigationView {
        Form {
          Section {
            TextField("Name of Drink", text: $viewModel.formData.name)
            TextField("Name of Venue", text: $viewModel.formData.venue)
          }.listRowBackground(Color.pink.opacity(0.3))
          Section {
            RatingView(rating: $viewModel.formData.rating)
          } header: {
            Text("Rate your drink!")
          }.listRowBackground(Color.pink.opacity(0.3))
          Section {
            Button("Save") {viewModel.save()}
          }.listRowBackground(Color.pink.opacity(0.3))
        }
        .navigationTitle("What did you drink?")
      }
    }
}

//struct RecipeForm_Previews: PreviewProvider {
//    static let recipeStore = RecipeStore()
//    static let viewModel = RecipeDetailVM(apiService: RecipeAPIService(), recipe: Recipe.previewData[0])
//    static var previews: some View {
//        RecipeDetail(viewModel: viewModel)
//    }
//}


