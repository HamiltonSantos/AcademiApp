//
//  HomeRouter.swift
//  AcademiApp
//
//  Created by Hamilton Carlos da Silva Santos on 25/06/23.
//

import SwiftUI

class HomeRouter {
    func makeSessionListView(for dataModel: DataModel) -> some View {
        let model = dataModel
        let interactor = SessionListInteractor(model: model)
        let presenter = SessionListPresenter(interactor: interactor)
        return SessionListView(presenter: presenter)
    }
}
