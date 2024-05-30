//
//  CreateDataApp.swift
//  CreateData
//
//  Created by Keith Sharp on 29/05/2024.
//

import SwiftData
import SwiftUI

@main
struct CreateDataApp: App {
    
    var container: ModelContainer
    
    init() {
        let configuration = ModelConfiguration(for: Challenge.self)
        do {
            self.container = try ModelContainer(for: Challenge.self, configurations: configuration)
        } catch {
            fatalError("Failed to setup SwiftData: \(error.localizedDescription)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            CreateChallengesView()
                .modelContainer(container)
        }
        .commands {
            CommandGroup(after: CommandGroupPlacement.newItem) {
                Divider()
                
                Button("Export") {
                    exportChallenges()
                }
                .keyboardShortcut("e", modifiers: .command)
            }
        }
    }
    
    @MainActor
    func exportChallenges() {
        let panel = NSOpenPanel()
        panel.canChooseDirectories = true
        panel.canChooseFiles = false
        panel.canCreateDirectories = true
        panel.showsTagField = false
        
        if panel.runModal() == .OK {
            guard let url = panel.url else {
                print("Somehow I can't get a URL for saving")
                return
            }
            
            if url.startAccessingSecurityScopedResource() {
                do {
                    // Get all the challenges from the main SwiftData datastore
                    let fetchDescriptor = FetchDescriptor<Challenge>()
                    let challenges = try container.mainContext.fetch(fetchDescriptor)
                    
                    // Create the export datastore
                    let exportConfig = ModelConfiguration(url: url.appending(path: Constants.challengesFilename))
                    let exportContainer = try ModelContainer(for: Challenge.self, configurations: exportConfig)
                    
                    // Copy the challenges to the exportContainer
                    for challenge in challenges {
                        let newChallenge = Challenge(from: challenge)
                        exportContainer.mainContext.insert(newChallenge)
                    }
                    try exportContainer.mainContext.save()
                    
                } catch {
                    print("Failed during export: \(error.localizedDescription)")
                }
                url.stopAccessingSecurityScopedResource()
            }
        }
        
    }
}
