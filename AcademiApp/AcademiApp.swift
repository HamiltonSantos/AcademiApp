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
        WindowGroup {
            let model = DataModel.sample
            ContentView().environmentObject(model)
        }
    }
}
