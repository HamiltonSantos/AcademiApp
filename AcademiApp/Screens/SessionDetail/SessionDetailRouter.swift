//
//  SessionDetailRouter.swift
//  AcademiApp
//
//  Created by Hamilton Carlos da Silva Santos on 05/06/23.
//

import SwiftUI

class SessionDetailRouter {
    
    func makeExerciseView(for exercise: Exercise, model: DataModel) -> some View {
        let presenter = ExerciseDetailPresenter(
            interactor:
                ExerciseDetailInteractor(
                    exercise: exercise,
                    model: model
                )
        )
        return ExerciseDetailView(presenter: presenter)
    }
}
