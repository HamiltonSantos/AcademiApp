//
//  CropRouter.swift
//  AcademiApp
//
//  Created by Hamilton Carlos da Silva Santos on 02/07/23.
//

import Foundation

class CropRouter {
    
    func makeCropView(for cropModel: CropModel) -> CropView {
        let interactor = CropInteractor(cropModel: cropModel)
        let presenter = CropPresenter(interactor: interactor)
        let view = CropView(presenter: presenter)
        return view
    }
}
