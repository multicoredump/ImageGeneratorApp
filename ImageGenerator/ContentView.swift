//
//  ContentView.swift
//  ImageGenerator
//
//  Created by Radhika Karandikar on 3/30/26.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(AppManager.self) private var appManager
    
    
    var body: some View {
        VStack {
            if appManager.showKitchen {
                KitchenView()
            } else {
                StartView()
            }
        }
        .frame(minWidth: ImageGenerator.imageSize, maxWidth: 400, minHeight: 550)
        .overlay {
            if appManager.isGenerating {
                loadingView()
            }
        }
    }

    
    // Add a loadingView function that shows a progress view and informative text while an image is generating.
    
    private func loadingView() -> some View {
        HStack(spacing: 8) {
            ProgressView()
            Text("Generating image...")
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    ContentView().previewEnvironment(generateImage: true)
}
