//
//  SessionListPresenter.swift
//  AcademiApp
//
//  Created by Hamilton Carlos da Silva Santos on 05/06/23.
//
import SwiftUI
import Combine

class SessionListPresenter: ObservableObject {
  private let interactor: SessionListInteractor
  private let router = SessionListRouter()
  
  private var cancellables = Set<AnyCancellable>()
  
  @Published var sessions: [Session] = []
  
  init(interactor: SessionListInteractor) {
    self.interactor = interactor
    
    interactor.model.$sessions
      .assign(to: \.sessions, on: self)
      .store(in: &cancellables)
  }
  
  func makeAddNewButton() -> some View {
    Button(action: addNewSession) {
      Image(systemName: "plus")
    }
  }
  
  func addNewSession() {
    interactor.addNewSession()
  }
  
  func deleteSession(_ index: IndexSet) {
    interactor.deleteSession(index)
  }
  
  func linkBuilder<Content: View>(for session: Session, @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(destination: router.makeDetailView(for: session, model: interactor.model)) {
      content()
    }
  }  
}
