//
//  ContentView.swift
//  AcademiApp
//
//  Created by Hamilton Carlos da Silva Santos on 10/06/23.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var model: DataModel

  var body: some View {
    NavigationView {
      HomeView(
        presenter: HomePresenter(
          interactor: HomeInteractor(
            model: model)
            )
      )            
    }
  }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let model = DataModel.sample
    return ContentView()
      .environmentObject(model)
  }
}
#endif
