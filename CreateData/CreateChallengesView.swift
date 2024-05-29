//
//  CreateChallengesView.swift
//  CreateData
//
//  Created by Keith Sharp on 29/05/2024.
//

import SwiftData
import SwiftUI

struct CreateChallengesView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query private var challenges: [Challenge]
    
    var body: some View {
        NavigationStack {
            HStack(alignment: .top) {
                Text("There are \(challenges.count) challenges")
                    .font(.title)
                Spacer()
                Button("Add") {
                    var rating: Rating? = nil
                    if Bool.random() {
                        rating = Rating.allCases.randomElement()
                    }
                    // Note the naming breaks if you delete a challenge
                    let challenge = Challenge(name: "Challenge #\(challenges.count)", rating: rating)
                    modelContext.insert(challenge)
                    do {
                        try modelContext.save()
                    } catch {
                        print("Failed when saving the newly added challenge: \(error.localizedDescription)")
                    }
                }
            }
            List(challenges) { challenge in
                VStack(alignment: .leading) {
                    HStack {
                        Text(challenge.name)
                            .font(.title2)
                        Spacer()
                        if let rating = challenge.rating {
                            Text(rating.rawValue)
                                .font(.title3)
                        }
                    }
                    Text(challenge.id.uuidString)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .swipeActions {
                    Button("Delete", systemImage: "trash", role: .destructive) {
                        modelContext.delete(challenge)
                    }
                }
            }
            .navigationTitle("Challenges")
        }
        .padding()
    }
}

#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Challenge.self, configurations: configuration)
    
    for idx in 1...10 {
        var rating: Rating? = nil
        if Bool.random() {
            rating = Rating.allCases.randomElement()
        }
        
        let challenge = Challenge(name: "Challenge #\(idx)", rating: rating)
        container.mainContext.insert(challenge)
    }
    
    return CreateChallengesView()
        .modelContainer(container)
}
