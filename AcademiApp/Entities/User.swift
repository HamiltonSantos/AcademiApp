//
//  User.swift
//  AcademiApp
//
//  Created by Hamilton Carlos da Silva Santos on 25/06/23.
//

import Foundation

final class User {

    let id: UUID
    @Published var name: String = ""
    @Published var objective: String = ""
    @Published var currentSession: Int = 0
    @Published var lastSession: Int = 0
    
    init() {
        id = UUID()
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: CodingKeys.name)
        name = try container.decode(String.self, forKey: CodingKeys.name)
        objective = try container.decode(String.self, forKey: CodingKeys.objective)
        currentSession = try container.decode(Int.self, forKey: CodingKeys.currentSession)
        lastSession = try container.decode(Int.self, forKey: CodingKeys.lastSession)
    }
}

extension User: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case objective
        case currentSession
        case lastSession
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: CodingKeys.name)
        try container.encode(objective, forKey: CodingKeys.objective)
        try container.encode(currentSession, forKey: CodingKeys.currentSession)
        try container.encode(lastSession, forKey: CodingKeys.lastSession)
    }
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.name == rhs.name &&
            lhs.objective == rhs.objective &&
            lhs.currentSession == rhs.currentSession &&
            lhs.lastSession == rhs.lastSession
    }
}

extension User: Identifiable {}

extension User: ObservableObject {}
