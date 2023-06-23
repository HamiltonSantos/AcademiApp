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
    
    var id: UUID
    @Published var name: String
    @Published var description: String
    @Published var restTime: Int
    @Published var videoURL: URL
    
    init() {
        id = UUID()
        name = ""
        description = ""
        restTime = 0
        videoURL = URL(string: "https://www.youtube.com/watch?v=TukPaRhRlZQ")!
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        id = try container.decode(UUID.self, forKey: .id)
        description = try container.decode(String.self, forKey: .description)
        restTime = try container.decode(Int.self, forKey: .restTime)
        videoURL = try container.decode(URL.self, forKey: .videoURL)
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

extension Exercise: Codable {
    enum CodingKeys: CodingKey {
        case name
        case location
        case id
        case description
        case restTime
        case videoURL
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
        try container.encode(description, forKey: .description)
        try container.encode(restTime, forKey: .restTime)
        try container.encode(videoURL, forKey: .videoURL)
    }
}

extension Exercise: Identifiable {}
