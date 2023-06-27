//
//  SessionDetailView.swift
//  AcademiApp
//
//  Created by Hamilton Carlos da Silva Santos on 05/06/23.
//

import SwiftUI

struct SessionDetailView: View {
    @ObservedObject var presenter: SessionDetailPresenter
    
    var body: some View {
        VStack {
            TextField("Session Name", text: presenter.setSessionName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding([.horizontal])
            HStack {
                Spacer()
                EditButton()
                Button(action: presenter.addExercise) {
                    Text("Add")
                }
            }.padding([.horizontal])
            List {
                ForEach(presenter.exercises, content: presenter.cell)
                    .onDelete(perform: presenter.didDeleteExercise(_:))
            }
        }
        .navigationBarTitle(Text(presenter.sessionName), displayMode: .inline)
        .navigationBarItems(trailing: Button("Save", action: presenter.save))
    }
}

struct SessionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let model = DataModel.sample
        let session = model.sessions[0]
        let presenter = SessionDetailPresenter(
            interactor:
                SessionDetailInteractor(
                    session: session,
                    model: model)
        )
        return NavigationView {
            SessionDetailView(presenter: presenter)
        }
    }
}
