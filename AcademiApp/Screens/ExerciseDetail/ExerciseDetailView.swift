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
            ZStack {
                TextEditor(text: presenter.setExerciseName)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal)
            }
            VideoView(videoID: "TukPaRhRlZQ")
                .cornerRadius(12)
                .padding(.horizontal, 24)
            Spacer()
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
        let exercise = model.sessions[0].exercises[0]
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
