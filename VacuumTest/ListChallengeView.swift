//
//  ListChallengeView.swift
//  VacuumTest
//
//  Created by Keith Sharp on 29/05/2024.
//

import SwiftData
import SwiftUI

struct ListChallengeView: View {
    
    @Query private var challenges: [Challenge]
    
    var body: some View {
        NavigationStack {
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
            }
            .navigationTitle("Challenges")
        }
    }
}

#Preview {
    let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Challenge.self, configurations: configuration)
    
    return ListChallengeView()
        .modelContainer(container)
}
