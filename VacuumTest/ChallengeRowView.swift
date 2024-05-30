//
//  ChallengeRowView.swift
//  VacuumTest
//
//  Created by Keith Sharp on 30/05/2024.
//

import SwiftData
import SwiftUI

struct ChallengeRowView: View {
    @Environment(\.modelContext) var completionRecordContext
    
    @Query private var records: [CompletionRecord]
    
    @Bindable var challenge: Challenge
    
    init(challenge: Challenge) {
        self.challenge = challenge
        
        let challengeID = challenge.id
        let predicate = #Predicate<CompletionRecord> { record in
            record.challengeID == challengeID
        }
        
        self._records = Query(filter: predicate)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(challenge.name)
                    .font(.title2)
                
                Spacer()
                
                if let record = records.first {
                    Text(record.date, style: .date)
                } else {
                    Button(action: {
                        let record = CompletionRecord(challengeID: challenge.id)
                        completionRecordContext.insert(record)
                        do {
                            try completionRecordContext.save()
                        } catch {
                            print("Failed to save completion record: \(error.localizedDescription)")
                        }
                    }, label: {
                        Text("Complete")
                    })
                }
            }
            Text(challenge.id.uuidString)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview("Not Completed") {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: CompletionRecord.self, Challenge.self, configurations: configuration)
    
    let challengeID = UUID()
    
    return ChallengeRowView(challenge: Challenge(id: challengeID, name: "Test Challenge"))
        .modelContainer(container)
        .challengesContainer(container)
}

#Preview("Completed") {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: CompletionRecord.self, Challenge.self, configurations: configuration)
    
    let challengeID = UUID()
    
    let record = CompletionRecord(challengeID: challengeID, date: .now)
    container.mainContext.insert(record)
    
    return ChallengeRowView(challenge: Challenge(id: challengeID, name: "Test Challenge"))
        .modelContainer(container)
        .challengesContainer(container)
}
