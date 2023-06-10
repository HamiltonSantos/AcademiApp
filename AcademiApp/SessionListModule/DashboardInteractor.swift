//
//  DashboardInteractor.swift
//  AcademiApp
//
//  Created by Hamilton Carlos da Silva Santos on 05/06/23.
//

import Foundation

class TripListInteractor {
  let model: DataModel

  init (model: DataModel) {
    self.model = model
  }

  func addNewSession() {
    model.pushNewSession()
  }
  
  func deleteSession(_ index: IndexSet) {
    model.sessions.remove(atOffsets: index)
  }
}
