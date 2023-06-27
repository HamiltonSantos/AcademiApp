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
            VStack {
                Image("backDay")
                    .ignoresSafeArea(edges: .top)
                    .frame(height: 300)
                    .clipped()
                
                CircleImage()
                    .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width / 2)
                    .offset(y: -130)
                    .padding(.bottom, -130)
                
                VStack(alignment: .leading) {
                    Text("Welcome, \(presenter.userName)!")
                        .font(.title)
                    HStack {
                        Text("Your objective is \(presenter.userObjective)")
                            .font(.subheadline)
                        Spacer()
                        Text("You are in session \(presenter.currentSession) of \(presenter.lastSession)")
                            .font(.subheadline)
                    }
                }
                NavigationLink(destination: presenter.makeSessionListView(for: DataModel.sample)) {
                    Text("Start Session")
                        .font(.title)
                        .padding()
                }
                Spacer()
            }
            .navigationBarTitle("Home")
            .ignoresSafeArea(edges: .top)
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
