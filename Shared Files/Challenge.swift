//
//  Challenge.swift
//  VacuumTest
//
//  Created by Keith Sharp on 29/05/2024.
//

import Foundation
import SwiftData

enum Rating: String, CaseIterable, Codable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
}

@Model
class Challenge: Identifiable {
    let id: UUID
    var name: String
    var rating: Rating?
    
    init(id: UUID = UUID(), name: String, rating: Rating? = nil) {
        self.id = id
        self.name = name
        self.rating = rating
    }
    
    init(from: Challenge) {
        self.id = from.id
        self.name = from.name
        self.rating = from.rating
    }
}
