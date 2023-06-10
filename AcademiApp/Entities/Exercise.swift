//
//  Exercise.swift
//  AcademiApp
//
//  Created by Hamilton Carlos da Silva Santos on 09/06/23.
//

import Combine
import CoreLocation
import MapKit

final class Exercise {
    @Published var name: String
    var id: UUID
    
    init() {
        id = UUID()
        name = "Bench Press"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        id = try container.decode(UUID.self, forKey: .id)
    }
    
    func copy() -> Exercise {
        let new = Exercise()
        new.name = name
        return new
    }
}

extension Exercise: Equatable {
    static func == (lhs: Exercise, rhs: Exercise) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Exercise: CustomStringConvertible {
    var description: String { name }
}

extension Exercise: Codable {
    enum CodingKeys: CodingKey {
        case name
        case location
        case id
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
    }
}

extension Exercise: Identifiable {}
