//
//  AcademiApp.swift
//  AcademiApp
//
//  Created by Hamilton Carlos da Silva Santos on 05/06/23.
//

import SwiftUI

@main
struct AcademiApp: App {
    var body: some Scene {
        let model = DataModel()
        model.load()
        return WindowGroup {
            ContentView().environmentObject(model)
        }
    }
}
