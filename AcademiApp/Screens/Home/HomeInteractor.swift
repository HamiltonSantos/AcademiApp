//
//  HomeInteractor.swift
//  AcademiApp
//
//  Created by Hamilton Carlos da Silva Santos on 25/06/23.
//

import Combine

class HomeInteractor {
    
    private let model: DataModel

    private var cancellables = Set<AnyCancellable>()

    var userName: String { model.user.name }
    var userNamePublisher: Published<String>.Publisher { model.user.$name }
    var userObjective: String { model.user.objective }
    var userObjectivePublisher: Published<String>.Publisher { model.user.$objective }
    var currentSession: Int { model.user.currentSession }
    var currentSessionPublisher: Published<Int>.Publisher { model.user.$currentSession }
    var lastSession: Int { model.user.lastSession }
    var lastSessionPublisher: Published<Int>.Publisher { model.user.$lastSession }

    init (model: DataModel) {
        self.model = model

    }

    func setUserName(_ name: String) {
        model.user.name = name
    }

    func setUserObjective(_ objective: String) {
        model.user.objective = objective
    }

    func setCurrentSession(_ currentSession: Int) {
        model.user.currentSession = currentSession
    }

    func setLastSession(_ lastSession: Int) {
        model.user.lastSession = lastSession
    }

    func save() {
        model.save()
    }

}
