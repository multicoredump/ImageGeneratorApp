//
//  ImageButtonsView.swift
//  ImageGenerator
//
//  Created by Radhika Karandikar on 3/30/26.
//

import SwiftUI

struct ImageButtonsView: View {
    @Environment(AppManager.self) private var appManager
    var displayForMenu = false
    
    var body: some View {
        if displayForMenu {
            Group {
                regenerateButton
                shareButton
            }
        } else {
            regenerateButton
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        shareButton
                    }
                }
        }
    }


    private var regenerateButton: some View {
        Button("Regenerate", systemImage: "arrow.clockwise") {
            appManager.generateImage()
        }
        .buttonStyle(.plain)
        .font(.footnote)
        .keyboardShortcut("r", modifiers: .command)
        .disabled(!appManager.showKitchen)
    }
    
    @ViewBuilder
    private var shareButton: some View {
        if let image = appManager.currentImage {
            let preview = SharePreview("My Recipe", image: image)
            ShareLink(item: image, preview: preview) {
                Label("Share", systemImage: "square.and.arrow.up")
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    ImageButtonsView(displayForMenu: true)
       .previewEnvironment(generateImage: false)
}
