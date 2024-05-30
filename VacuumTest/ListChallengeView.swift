//
//  ListChallengeView.swift
//  VacuumTest
//
//  Created by Keith Sharp on 29/05/2024.
//

import SwiftData
import SwiftUI

struct ListChallengeView: View {
    @Environment(\.modelContext) var completionRecordContext
    @Environment(\.challengesContainer) var challengesContainer: ModelContainer
    
    @MainActor
    func getChallenges() -> [Challenge] {
        let fd = FetchDescriptor<Challenge>()
        do {
            let challenges = try challengesContainer.mainContext.fetch(fd)
            return challenges
        } catch {
            print("Failed to fetch challenges: \(error.localizedDescription)")
        }
        return []
    }
    
    var body: some View {
        NavigationStack {
            List(getChallenges()) { challenge in
                ChallengeRowView(challenge: challenge)
            }
            .navigationTitle("Challenges")
        }
    }
}

#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: CompletionRecord.self, Challenge.self, configurations: configuration)
    
    for idx in 1...10 {
        let challenge = Challenge(name: "Challenge \(idx)")
        container.mainContext.insert(challenge)
    }
    
    return ListChallengeView()
        .modelContainer(container)
        .challengesContainer(container)
}
