//
//  SessionDetailInteractor.swift
//  AcademiApp
//
//  Created by Hamilton Carlos da Silva Santos on 05/06/23.
//

import Combine
import MapKit

class SessionDetailInteractor {
    private let session: Session
    let model: DataModel
    
    private var cancellables = Set<AnyCancellable>()
    
    var sessionName: String { session.name }
    var sessionNamePublisher: Published<String>.Publisher { session.$name }
    @Published var exercises: [Exercise] = []
    
    
    init (session: Session, model: DataModel) {
        self.session = session
        self.model = model
        
        session.$exercises
            .assign(to: \.exercises, on: self)
            .store(in: &cancellables)
        
    }
    
    func setSessionName(_ name: String) {
        session.name = name
    }
    
    func save() {
        model.save()
    }
    
    // MARK: - Waypoints
    
    func addExercise() {
        session.addExercise()
    }
    
    func deleteExercise(atOffsets: IndexSet) {
        session.exercises.remove(atOffsets: atOffsets)
    }
    
    func updateExercises() {
        session.exercises = session.exercises
    }
}
