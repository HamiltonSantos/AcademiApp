//
//  HomePresenter.swift
//  AcademiApp
//
//  Created by Hamilton Carlos da Silva Santos on 25/06/23.
//

import SwiftUI
import Combine

class HomePresenter: ObservableObject {
    private let interactor: HomeInteractor
    private let router: HomeRouter
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var userName: String = "Hamilton"
    let setUserName: Binding<String>
    @Published var userObjective: String = "Hypertrophy"
    let setUserObjective: Binding<String>
    @Published var currentSession: Int = 1
    let setCurrentSession: Binding<Int>
    @Published var lastSession: Int = 50
    let setLastSession: Binding<Int>
    
    
    init(interactor: HomeInteractor) {
        self.interactor = interactor
        self.router = HomeRouter()
        
    setUserName = Binding<String>(
        get: { interactor.userName },
        set: { interactor.setUserName($0) }
    )

     setUserObjective = Binding<String>(
        get: { interactor.userObjective },
        set: { interactor.setUserObjective($0) }   
     )

     setCurrentSession = Binding<Int>(
        get: { interactor.currentSession },
        set: { interactor.setCurrentSession($0) }
     )

     setLastSession = Binding<Int>(
        get: { interactor.lastSession },
        set: { interactor.setLastSession($0) }
     )
     
    }
    
    func save() {
        interactor.save()
    }

    func makeSessionListView(for dataModel: DataModel) -> some View {
        router.makeSessionListView(for: dataModel)
    }
}
