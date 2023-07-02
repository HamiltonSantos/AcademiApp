//
//  Model.swift
//  AcademiApp
//
//  Created by Hamilton Carlos da Silva Santos on 02/07/23.
//

import Foundation

enum CropModel: Equatable {
    case profile
    case banner

    func name() -> String {
        switch self {
        case .profile:
            return "Profile"
        case .banner:
            return "Banner"
        }
    }

    func aspectRatio() -> Double {
        switch self {
        case .profile:
            return 1
        case .banner:
            return 16/9
        }
    }

    func cropSize() -> CGSize {
        switch self {
        case .profile:
            return CGSize(width: 300, height: 300)
        case .banner:
            return CGSize(width: 1200, height: 675)
        }
    }
}
