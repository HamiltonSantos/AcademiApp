//
//  ExerciseDetailInteractor.swift
//  AcademiApp
//
//  Created by Hamilton Carlos da Silva Santos on 05/06/23.
//

import Combine
import MapKit

class ExerciseDetailInteractor {
    private let exercise: Exercise
    private let model: DataModel
    
    private var cancellables = Set<AnyCancellable>()
    
    var exerciseName: String { exercise.name }
    var exerciseNamePublisher: Published<String>.Publisher { exercise.$name }
    var exerciseDescription: String { exercise.description }
    var exerciseDescriptionPublisher: Published<String>.Publisher { exercise.$description }
    var exerciseRestTime: Int { exercise.restTime }
    var exerciseRestTimePublisher: Published<Int>.Publisher { exercise.$restTime }
    var exerciseVideoURL: URL { exercise.videoURL }
    var exerciseVideoURLPublisher: Published<URL>.Publisher { exercise.$videoURL }
    
    init (exercise: Exercise, model: DataModel) {
        self.exercise = exercise
        self.model = model
        
    }
    
    func setExerciseName(_ name: String) {
        exercise.name = name
    }

    func setExerciseDescription(_ description: String) {
        exercise.description = description
    }

    func setExerciseRestTime(_ restTime: Int) {
        exercise.restTime = restTime
    }

    func setExerciseVideoURL(_ videoURL: URL) {
        exercise.videoURL = videoURL
    }   
    
    func save() {
        model.save()
    }
}
