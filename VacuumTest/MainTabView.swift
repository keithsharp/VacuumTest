//
//  MainTabView.swift
//  VacuumTest
//
//  Created by Keith Sharp on 30/05/2024.
//

import SwiftData
import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            ListChallengeView()
                .tabItem {
                    Label("Challenges", systemImage: "figure.walk.motion")
                }
            
            ListCompletionsView()
                .tabItem {
                    Label("Completions", systemImage: "checkmark.circle")
                }
        }
    }
}

#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: CompletionRecord.self, Challenge.self, configurations: configuration)
    
    return MainTabView()
        .modelContainer(container)
        .challengesContainer(container)
}
