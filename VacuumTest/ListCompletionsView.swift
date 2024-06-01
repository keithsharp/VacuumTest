//
//  ListCompletionsView.swift
//  VacuumTest
//
//  Created by Keith Sharp on 30/05/2024.
//

import SwiftData
import SwiftUI

struct ListCompletionsView: View {
    @Environment(\.modelContext) var completionRecordContext
    @Environment(\.challengesContainer) var challengesContainer: ModelContainer
    
    @Query(sort: \CompletionRecord.date) private var records: [CompletionRecord]
    
    @MainActor
    func challengeWith(id: UUID) -> Challenge? {
        let predicate = #Predicate<Challenge> { challenge in
            challenge.id == id
        }
        let fetchDescriptor = FetchDescriptor(predicate: predicate)
        do {
            let challenges = try challengesContainer.mainContext.fetch(fetchDescriptor)
            return challenges.first
        } catch {
            print("Failed to find challenge \(id): \(error.localizedDescription)")
        }
        return nil
    }
    
    var body: some View {
        NavigationStack {
            List(records) { record in
                HStack {
                    Text("\(challengeWith(id: record.challengeID)?.name ?? "Unknown challenge") completed:")
                    
                    Spacer()
                    
                    Text(record.date, style: .date)
                }
                .swipeActions {
                    Button("Delete", systemImage: "trash", role: .destructive) {
                        completionRecordContext.delete(record)
                    }
                }
            }
            .navigationTitle("Completions")
        }
    }
}

#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: CompletionRecord.self, Challenge.self, configurations: configuration)
    
    let challengeID = UUID()
    let challenge = Challenge(id: challengeID, name: "Test challenge", rating: .easy)
    container.mainContext.insert(challenge)
    
    let record = CompletionRecord(challengeID: challengeID, date: .now)
    container.mainContext.insert(record)
    
    return ListCompletionsView()
        .modelContainer(container)
        .challengesContainer(container)
}
