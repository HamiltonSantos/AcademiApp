//
//  CropPresenter.swift
//  AcademiApp
//
//  Created by Hamilton Carlos da Silva Santos on 02/07/23.
//

import Foundation

class CropPresenter: ObservableObject {
    private let interactor: CropInteractor
    private let router: CropRouter

    init(interactor: CropInteractor) {
        self.interactor = interactor
        self.router = CropRouter()
    }
}
