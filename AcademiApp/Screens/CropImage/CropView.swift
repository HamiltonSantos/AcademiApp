//
//  GalleryView.swift
//  AcademiApp
//
//  Created by Hamilton Carlos da Silva Santos on 02/07/23.
//

import SwiftUI
import PhotosUI

struct CropView: View {

    @ObservedObject var presenter: CropPresenter

    @State private var photosPickerItem: PhotosPickerItem?
    
    var body: some View {
        HStack(spacing: 10) {
            PhotosPicker(selection: $photosPickerItem) {
                Label("Select Photo", systemImage: "photo")
            }
        }
        .padding()
    }
}


struct CropView_Previews: PreviewProvider {
    static var previews: some View {
        let model = CropModel.banner
        let presenter = CropPresenter(
            interactor: CropInteractor(cropModel: model)
        )
        return CropView(presenter: presenter)
    }
}
