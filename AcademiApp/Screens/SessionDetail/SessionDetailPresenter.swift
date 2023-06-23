//
//  SessionDetailPresenter.swift
//  AcademiApp
//
//  Created by Hamilton Carlos da Silva Santos on 05/06/23.
//

import SwiftUI
import Combine

class SessionDetailPresenter: ObservableObject {
    private let interactor: SessionDetailInteractor
    private let router: SessionDetailRouter
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var sessionName: String = "No name"
    let setSessionName: Binding<String>
    @Published var exercises: [Exercise] = []
    
    init(interactor: SessionDetailInteractor) {
        self.interactor = interactor
        self.router = SessionDetailRouter()
        
        setSessionName = Binding<String>(
            get: { interactor.sessionName },
            set: { interactor.setSessionName($0) }
        )
        
        interactor.sessionNamePublisher
            .assign(to: \.sessionName, on: self)
            .store(in: &cancellables)
        
        interactor.$exercises
            .assign(to: \.exercises, on: self)
            .store(in: &cancellables)
    }
    
    func save() {
        interactor.save()
    }
    
    // MARK: - Exercises
    
    func addExercise() {
        interactor.addExercise()
    }
    
    func didDeleteExercise(_ atOffsets: IndexSet) {
        interactor.deleteExercise(atOffsets: atOffsets)
    }
    
    func cell(for exercise: Exercise) -> some View {
        let destination = router.makeExerciseView(for: exercise, model: interactor.model)
            .onDisappear(perform: interactor.updateExercises)
        return NavigationLink(destination: destination) {
            Text(exercise.name)
        }
    }
}
