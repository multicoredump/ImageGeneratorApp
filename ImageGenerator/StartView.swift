//
//  StartView.swift
//  ImageGenerator
//
//  Created by Radhika Karandikar on 3/30/26.
//

import SwiftUI
import ImagePlayground

struct StartView: View {
    
    @Environment(AppManager.self) private var appManager
    
    
    
    var body: some View {
        
        // Replace the ImageGenerator with the AppManager provided in the preview.
        // Bindable creates a binding to a property of an Observable class.
        @Bindable var imageGenerator = appManager.imageGenerator
        
        VStack(spacing: 16) {
            Text("Create a Unique Dish")
                .font(.largeTitle.weight(.semibold))
            Label("Choose a dish", systemImage: "fork.knife")
                    .padding(.top, 8)
            Picker("Recipes", selection: $imageGenerator.recipe) {
                ForEach(ImageGenerator.recipes, id: \.description) { recipe in
                    Text(recipe)
                }
            }


            Label("Choose an image style", systemImage: "paintpalette.fill")
                .padding(.top, 8)
            Picker("Styles", selection: $imageGenerator.style) {
                ForEach(ImageGenerator.styles) { style in
                    Text(style.id.capitalized)
                        .tag(style)
                }
            }



            Spacer()
        }
        // Add Generate Image button in toolbar
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                // Start image generation when the user clicks Generate Image. Disable the button until an image style is selected, because generateImage requires a style.
                Button("Generate Image") {
                    appManager.generateImage()

                }
                .buttonStyle(.glassProminent)
                .disabled(imageGenerator.style == nil)
            }
        }
        .pickerStyle(.segmented)
        .labelsHidden()
        .frame(width: ImageGenerator.imageSize)
        .padding()

    }
        
}

#Preview {
    StartView()
}
