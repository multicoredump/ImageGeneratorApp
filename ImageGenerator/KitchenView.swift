//
//  KitchenView.swift
//  ImageGenerator
//
//  Created by Radhika Karandikar on 3/30/26.
//

import SwiftUI

struct KitchenView: View {
    @Environment(AppManager.self) private var appManager
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Refine Your Dish")
                .font(.largeTitle.weight(.semibold))
            imageArea
            // In KitchenView, pin the preview, then initialize an ImageButtonsView below the image area.
            ImageButtonsView()
            IngredientListView()
            Spacer()
            // Display any errors at the bottom of the kitchen view.
            if let error = appManager.error {
                Text(error.localizedDescription)
                    .foregroundStyle(Color.red)
            }
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button("Start Over", systemImage: "chevron.left") {
                    appManager.reset()
                }
            }
        }
    }
    
    
    // Reserve a dedicated image area so the layout remains constant during and after generation. Display a rectangle with a gray background to define the bounds and improve contrast.
    private var imageArea: some View {
        Group {
            if let image = appManager.currentImage {
                Image(nsImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Rectangle()
                    .fill(.gray.opacity(0.2))
            }
        }
        .frame(width: ImageGenerator.imageSize, height: ImageGenerator.imageSize)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    KitchenView()
        .previewEnvironment()
}
