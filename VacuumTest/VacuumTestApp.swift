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
    
    var container: ModelContainer
    
    init() {
        guard let challengesURL = Bundle.main.url(forResource: Constants.exportFilename, withExtension: nil)  else {
            fatalError("Could not find Challenges datastore in bundle.")
        }
        
        let configuration = ModelConfiguration(url: challengesURL)
        do {
            self.container = try ModelContainer(for: Challenge.self, configurations: configuration)
        } catch {
            fatalError("Failed to setup SwiftData for Challenges: \(error.localizedDescription)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ListChallengeView()
                .modelContainer(container)
        }
    }
}
