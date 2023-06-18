//
//  Persistence.swift
//  AcademiApp
//
//  Created by Hamilton Carlos da Silva Santos on 05/06/23.
//

import Foundation
import Combine

fileprivate struct Envelope: Codable {
  let sessions: [Session]
}

/// This class can be refactored to save/load over a network instead of a local file
class Persistence {
  var localFile: URL {
    let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("sessions.json")
    print("In case you need to delete the database: \(fileURL)")
    return fileURL
  }

  var defaultFile: URL {
    return Bundle.main.url(forResource: "default", withExtension: "json")!
  }
  
  private func clear() {
    try? FileManager.default.removeItem(at: localFile)
  }

  func load() -> AnyPublisher<[Session], Never>  {
    if FileManager.default.fileExists(atPath: localFile.standardizedFileURL.path) {
      return Future<[Session], Never> { promise in
        self.load(self.localFile) { sessions in
          DispatchQueue.main.async {
            promise(.success(sessions))
          }
        }
      }.eraseToAnyPublisher()
    } else {
      return loadDefault()
    }
  }

  func save(sessions: [Session]) {
    let envelope = Envelope(sessions: sessions)
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    let data = try! encoder.encode(envelope)
    try! data.write(to: localFile)
  }

  private func loadSynchronously(_ file: URL) -> [Session] {
    do {
      let data = try Data(contentsOf: file)
      let envelope = try JSONDecoder().decode(Envelope.self, from: data)
      return envelope.sessions
    } catch {
      clear()
      return loadSynchronously(defaultFile)
    }
  }

  private func load(_ file: URL, completion: @escaping ([Session]) -> Void) {
    DispatchQueue.global(qos: .background).async {
      let sessions = self.loadSynchronously(file)
      completion(sessions)
    }
  }

  func loadDefault(synchronous: Bool = false) -> AnyPublisher<[Session], Never> {
    if synchronous {
      return Just<[Session]>(loadSynchronously(defaultFile)).eraseToAnyPublisher()
    }
    return Future<[Session], Never> { promise in
      self.load(self.defaultFile) { sessions in
        DispatchQueue.main.async {
          promise(.success(sessions))
        }
      }
    }.eraseToAnyPublisher()
  }
}
