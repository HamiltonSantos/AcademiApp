//
//  DataModel.swift
//  AcademiApp
//
//  Created by Hamilton Carlos da Silva Santos on 05/06/23.
//

import Combine

final class DataModel {
    private let persistence = Persistence()
    
    @Published var username: String = ""
    @Published var sessions: [Session] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    func load() {
        persistence.load()
            .assign(to: \.sessions, on: self)
            .store(in: &cancellables)
    }
    
    func save() {
        persistence.save(sessions: sessions)
    }
    
    func loadDefault(synchronous: Bool = false) {
        persistence.loadDefault(synchronous: synchronous)
            .assign(to: \.sessions, on: self)
            .store(in: &cancellables)
    }
    
    func pushNewSession() {
        let new = Session()
        new.name = "New Session"
        sessions.insert(new, at: 0)
    }
    
    func removeSession(session: Session) {
        sessions.removeAll { $0.id == session.id }
    }
}

extension DataModel: ObservableObject {}

/// Extension for SwiftUI previews
#if DEBUG
extension DataModel {
    static var sample: DataModel {
        let model = DataModel()
        model.loadDefault(synchronous: true)
        return model
    }
}
#endif
