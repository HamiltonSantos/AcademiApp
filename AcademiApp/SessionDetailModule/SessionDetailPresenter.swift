//
//  SessionDetailPresenter.swift
//  AcademiApp
//
//  Created by Hamilton Carlos da Silva Santos on 05/06/23.
//

import SwiftUI
import Combine

class TripDetailPresenter: ObservableObject {
  private let interactor: SessionDetailInteractor
  private let router: SessionDetailRouter

  private var cancellables = Set<AnyCancellable>()

  @Published var sessionName: String = "No name"
  let setSessionName: Binding<String>
  @Published var distanceLabel: String = "Calculating..."
  @Published var waypoints: [Waypoint] = []

  init(interactor: SessionDetailInteractor) {
    self.interactor = interactor
    self.router = SessionDetailRouter(mapProvider: interactor.mapInfoProvider)

    // 1
    setSessionName = Binding<String>(
      get: { interactor.sessionName },
      set: { interactor.setSessionName($0) }
    )

    // 2
    interactor.sessionNamePublisher
      .assign(to: \.sessionName, on: self)
      .store(in: &cancellables)

    interactor.$totalDistance
      .map { "Total Distance: " + MeasurementFormatter().string(from: $0) }
      .replaceNil(with: "Calculating...")
      .assign(to: \.distanceLabel, on: self)
      .store(in: &cancellables)

    interactor.$waypoints
      .assign(to: \.waypoints, on: self)
      .store(in: &cancellables)
  }

  func save() {
    interactor.save()
  }

  func makeMapView() -> some View {
      SessionMapView(presenter: SessionMapViewPresenter(interactor: interactor))
  }

  // MARK: - Waypoints

  func addWaypoint() {
    interactor.addWaypoint()
  }

  func didMoveWaypoint(fromOffsets: IndexSet, toOffset: Int) {
    interactor.moveWaypoint(fromOffsets: fromOffsets, toOffset: toOffset)
  }

  func didDeleteWaypoint(_ atOffsets: IndexSet) {
    interactor.deleteWaypoint(atOffsets: atOffsets)
  }

  func cell(for waypoint: Waypoint) -> some View {
    let destination = router.makeWaypointView(for: waypoint)
      .onDisappear(perform: interactor.updateWaypoints)
    return NavigationLink(destination: destination) {
      Text(waypoint.name)
    }
  }
}
