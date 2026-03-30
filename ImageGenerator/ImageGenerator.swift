//
//  ImageGenerator.swift
//  ImageGenerator
//
//  Created by Radhika Karandikar on 3/30/26.
//

import Foundation
import SwiftUI
import ImagePlayground

@Observable
class ImageGenerator {
    var recipe = ImageGenerator.defaultRecipe
    var style: ImagePlaygroundStyle?
    var ingredients: [String] = []
    
    // Include the ingredients in your ImagePlaygroundConcept array along with the recipe.
    var concepts: [ImagePlaygroundConcept] {
        var playgroundConcepts = [ImagePlaygroundConcept.text(recipe)]
        for ingredient in ingredients {
            playgroundConcepts.append(.text(ingredient))
        }
        return playgroundConcepts
    }
    
    func generate() async throws -> ImageCreator.CreatedImage {
        guard let style else {throw ImageCreator.Error.creationFailed }
        
        let imageCreator = try await ImageCreator()
        let images = imageCreator.images(for: concepts, style: style, limit: 1)
        
        // wait for results and resturn the first generated image
        for try await image in images {
            return image
        }
        
        throw ImageCreator.Error.creationFailed
    }
    
    func resetGenerator() {
        recipe = ImageGenerator.defaultRecipe
        style = nil
        ingredients.removeAll()
    }
    
}

extension ImageGenerator {
    static let recipes = ["Salad", "Sandwich", "Ice Cream"]
    static let styles: [ImagePlaygroundStyle] = [
        .animation,
        .illustration,
        .sketch
    ]


    static let imageSize: CGFloat = 256

    private static let defaultRecipe = recipes[0]
}
