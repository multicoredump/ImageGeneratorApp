//
//  AppManager.swift
//  ImageGenerator
//
//  Created by Radhika Karandikar on 3/30/26.
//

import SwiftUI
import ImagePlayground

@Observable
class AppManager {
    let imageGenerator  = ImageGenerator()
    var currentImage: NSImage?
    
    // store the image generation Task in a variable.
    // The second is the error type if the task fails; here, since errors are caught, the Never type expresses that the task handles errors itself instead of failing.
    private var task: Task<Void, Never>?
    
    // Add an error property and store any error resulting from image generation
    private(set) var error: Error?
    // Add a property to track when the image generator is creating an image.
    private(set) var isGenerating: Bool = false
    
    func generateImage() {
        // reset error when new generation starts
        error = nil
        isGenerating = true
        
        task = Task {
            do {
                let generatedImage = try await imageGenerator.generate()
                currentImage = NSImage(cgImage: generatedImage.cgImage, size: .zero)
                isGenerating = false
                
            } catch {
                do {
                    try Task.checkCancellation()
                    self.error = error
                    isGenerating = false
                } catch {
                    // Task cancelled
                }
            }
        }
    }
    
    func reset() {
        imageGenerator.resetGenerator()
        currentImage = nil
        error = nil
        isGenerating = false
        // Cancel the task when generateImage or reset is called
        task?.cancel()
    }
    
    // adds an ingredient and generates an image
    func add(ingredient: String) {
        imageGenerator.ingredients.append(ingredient)
        generateImage()
    }
    
    // removing ingredients. Find the correct index to remove the selected ingredient.
    func remove(ingredient: String) {
        if let i = imageGenerator.ingredients.firstIndex(of: ingredient) {
            imageGenerator.ingredients.remove(at: i)
        }
        generateImage()
    }
    
    var showKitchen: Bool {
        currentImage != nil || isGenerating
    }
}

/* In an extension, create a function that initializes an AppManager
 and adds it to the environment.
*/

extension View {
    func previewEnvironment(generateImage: Bool = true) -> some View {
    let appManager = AppManager()
    appManager.imageGenerator.ingredients.append("strawberry")
    return environment(appManager)
        .onAppear {
            if generateImage {
                appManager.imageGenerator.style = .animation
                appManager.generateImage()
            }
        }
    }
}
