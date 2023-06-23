//
//  Session.swift
//  AcademiApp
//
//  Created by Hamilton Carlos da Silva Santos on 05/06/23.
//

import Foundation
import Combine
import SwiftUI

final class Session {
    @Published var name: String = ""
    @Published var image: Image = Image("backDay")
    @Published var exercises: [Exercise] = []
    let id: UUID
    
    init() {
        id = UUID()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        exercises = try container.decode([Exercise].self, forKey: .exercises)
        id = try container.decode(UUID.self, forKey: .id)
    }
    
    func addExercise() {
        let exercise = exercises.last?.copy() ?? Exercise()
        exercise.name = ""
        exercises.append(exercise)
    }
}

extension Session: Codable {
    enum CodingKeys: CodingKey {
        case name
        case exercises
        case id
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(exercises, forKey: .exercises)
        try container.encode(id, forKey: .id)
    }
}

extension Session: Equatable {
    static func == (lhs: Session, rhs: Session) -> Bool {
        lhs.id == rhs.id
    }
}

extension Session: Identifiable {}

extension Session: ObservableObject {}
