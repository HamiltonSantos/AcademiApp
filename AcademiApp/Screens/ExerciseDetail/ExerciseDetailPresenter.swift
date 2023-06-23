//
//  ExerciseDetailPresenter.swift
//  AcademiApp
//
//  Created by Hamilton Carlos da Silva Santos on 05/06/23.
//

import SwiftUI
import Combine

class ExerciseDetailPresenter: ObservableObject {
    private let interactor: ExerciseDetailInteractor
    private let router: ExerciseDetailRouter
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var exerciseName: String = "No name"
    let setExerciseName: Binding<String>
    @Published var exerciseDescription: String = ""
    let setExerciseDescription: Binding<String>
    @Published var exerciseRestTime: Int = 0
    let setExerciseRestTime: Binding<Int>
    @Published var exerciseVideoURL: URL = URL(string: "https://www.youtube.com/watch?v=QwievZ1Tx-8")!
    let setExerciseVideoURL: Binding<URL>
    
    init(interactor: ExerciseDetailInteractor) {
        self.interactor = interactor
        self.router = ExerciseDetailRouter()
        
        setExerciseName = Binding<String>(
            get: { interactor.exerciseName },
            set: { interactor.setExerciseName($0) }
        )

        setExerciseDescription = Binding<String>(
            get: { interactor.exerciseDescription },
            set: { interactor.setExerciseDescription($0) }
        )

        setExerciseRestTime = Binding<Int>(
            get: { interactor.exerciseRestTime },
            set: { interactor.setExerciseRestTime($0) }
        )

        setExerciseVideoURL = Binding<URL>(
            get: { interactor.exerciseVideoURL },
            set: { interactor.setExerciseVideoURL($0) }
        )
        
    }
    
    func save() {
        interactor.save()
    }
}
