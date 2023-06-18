//
//  SessionListView.swift
//  AcademiApp
//
//  Created by Hamilton Carlos da Silva Santos on 05/06/23.
//

import SwiftUI

struct SessionListView: View {
  @ObservedObject var presenter: SessionListPresenter
  
  var body: some View {
    List {
      ForEach (presenter.sessions, id: \.id) { item in
        self.presenter.linkBuilder(for: item) {
          SessionListCell(session: item)
            .frame(height: 240)
        }
      }
      .onDelete(perform: presenter.deleteSession)
    }
    .navigationBarTitle("Sessions", displayMode: .inline)
    .navigationBarItems(trailing: presenter.makeAddNewButton())
  }
}

struct SessionListView_Previews: PreviewProvider {
  static var previews: some View {
    let model = DataModel.sample
    let interactor = SessionListInteractor(model: model)
    let presenter = SessionListPresenter(interactor: interactor)
    return NavigationView {
      SessionListView(presenter: presenter)
    }
  }
}
