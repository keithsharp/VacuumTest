//
//  CompletionRecord.swift
//  VacuumTest
//
//  Created by Keith Sharp on 30/05/2024.
//

import Foundation
import SwiftData

@Model
class CompletionRecord {
    let id: UUID
    let challengeID: UUID
    var date: Date
    
    init(id: UUID = UUID(), challengeID: UUID, date: Date = .now) {
        self.id = id
        self.challengeID = challengeID
        self.date = date
    }
}
