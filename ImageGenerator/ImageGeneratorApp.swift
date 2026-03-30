//
//  ImageGeneratorApp.swift
//  ImageGenerator
//
//  Created by Radhika Karandikar on 3/30/26.
//

import SwiftUI

@main
struct ImageGeneratorApp: App {
    
    @State var appManager = AppManager()
    
    var body: some Scene {
        Window("ImageGenerator", id: "main") {
            ContentView()
                .environment(appManager)
        }
        .commands {
            CommandMenu("Actions") {
                ImageButtonsView(displayForMenu: true)
                                    .environment(appManager)

            }
        }
    }
}
