//
//  VacuumTestApp.swift
//  VacuumTest
//
//  Created by Keith Sharp on 29/05/2024.
//

import SwiftData
import SwiftUI

@main
struct VacuumTestApp: App {
    
    var completionContainer: ModelContainer
    var challengesContainer: ModelContainer
    
    init() {
        guard let challengesURL = Bundle.main.url(forResource: Constants.challengesFilename, withExtension: nil)  else {
            fatalError("Could not find Challenges datastore in bundle.")
        }
        
        let challengesConfig = ModelConfiguration(url: challengesURL)
        do {
            self.challengesContainer = try ModelContainer(for: Challenge.self, configurations: challengesConfig)
        } catch {
            fatalError("Failed to setup SwiftData for Challenges: \(error.localizedDescription)")
        }
        
        let completionURL = URL.applicationSupportDirectory.appending(path: Constants.completionsFilename)
        let completionConfig = ModelConfiguration(url: completionURL)
        do {
            self.completionContainer = try ModelContainer(for: CompletionRecord.self, configurations: completionConfig)
        } catch {
            fatalError("Failed to setup SwiftData for CompletionRecord: \(error.localizedDescription)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .challengesContainer(challengesContainer)
                .modelContainer(completionContainer)
        }
    }
}
