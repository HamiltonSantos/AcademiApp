//
//  DashboardRouter.swift
//  AcademiApp
//
//  Created by Hamilton Carlos da Silva Santos on 05/06/23.
//

import SwiftUI

class SessionListRouter {
  func makeDetailView(for session: Session, model: DataModel) -> some View {
    let presenter = SessionDetailPresenter(interactor:
      SessionDetailInteractor(
        session: session,
        model: model,
        mapInfoProvider: RealMapDataProvider()))
    return SessionDetailView(presenter: presenter)
  }
}
