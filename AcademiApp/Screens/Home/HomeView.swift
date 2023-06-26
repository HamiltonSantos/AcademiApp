//
//  Home.swift
//  AcademiApp
//
//  Created by Hamilton Carlos da Silva Santos on 25/06/23.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var presenter: HomePresenter
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome, \(presenter.userName)!")
                    .font(.title)
                    .padding()
                Text("Your objective is \(presenter.userObjective)")
                    .font(.title2)
                    .padding()
                Text("You are in session \(presenter.currentSession) of \(presenter.lastSession)")
                    .font(.title2)
                    .padding()
                Spacer()
                NavigationLink(destination: presenter.makeSessionListView(for: DataModel.sample)) {
                    Text("Start Session")
                        .font(.title)
                        .padding()
                }
                Spacer()
            }
            .navigationBarTitle("Home")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let model = DataModel.sample
        let presenter = HomePresenter(
            interactor: HomeInteractor(model: model)
        )
        return HomeView(presenter: presenter)
    }
}
