//
//  ExerciseDetailView.swift
//  AcademiApp
//
//  Created by Hamilton Carlos da Silva Santos on 05/06/23.
//

import SwiftUI

struct ExerciseDetailView: View {
    @ObservedObject var presenter: ExerciseDetailPresenter
    
    var body: some View {
        VStack {
            TextField("Exercise Name", text: presenter.setExerciseName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding([.horizontal])
            Text("test")
            HStack {
                Spacer()
                EditButton()
            }.padding([.horizontal])
        }
        .navigationBarTitle(Text(presenter.exerciseName), displayMode: .inline)
        .navigationBarItems(trailing: Button("Save", action: presenter.save))
    }
}

struct ExerciseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let model = DataModel.sample
        let exercise = model.sessions[1].exercises[1]
        let presenter = ExerciseDetailPresenter(
            interactor:
                ExerciseDetailInteractor(
                    exercise: exercise,
                    model: model)
        )
        return NavigationView {
            ExerciseDetailView(presenter: presenter)
        }
    }
}
