//
//  IngredientListView.swift
//  ImageGenerator
//
//  Created by Radhika Karandikar on 3/30/26.
//

import SwiftUI

struct IngredientListView: View {
    @Environment(AppManager.self) private var appManager
    @State private var newIngredient = ""
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            TextField("Add ingredients (optional)", text: $newIngredient)
                .textFieldStyle(.roundedBorder)
                //Add an .onSubmit modifier to tell AppManager to add the ingredient, then reset the text field.
                .onSubmit {
                    appManager.add(ingredient: newIngredient)
                    newIngredient = ""
                }
            if !appManager.imageGenerator.ingredients.isEmpty {
                Text("Added Ingredients")
                    .font(.body.bold())
                    .padding(.vertical, 8)
                LazyVGrid(columns: [GridItem(), GridItem()]) {
                    ForEach(appManager.imageGenerator.ingredients, id: \.description) { ingredient in
                        field(ingredient: ingredient)
                    }
                }
            }
        }
    }
    
    // Add a function for the ingredient field that shows each ingredient with white text on a blue capsule.
    //Add a close button to remove the ingredient and regenerate the image. Lay the text and button out on a single line.
    
    private func field(ingredient: String) -> some View {
        HStack {
            Text(ingredient.capitalized).lineLimit(1)
            Spacer()
            Button {
               appManager.remove(ingredient: ingredient)
           } label: {
               Image(systemName: "xmark.circle.fill")
           }
           .buttonStyle(.plain)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .foregroundStyle(.white)
        .background(.blue, in: Capsule())
    }
}

#Preview {
    IngredientListView()
        .previewEnvironment()
}
