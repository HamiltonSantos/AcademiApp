//
//  CustomImagePicker.swift
//  AcademiApp
//
//  Created by Hamilton Carlos da Silva Santos on 02/07/23.
//

import SwiftUI
import PhotosUI


extension View {
    @ViewBuilder
    func cropImagePicker(options: [Crop], show: Binding<Bool>, croppedImage: Binding<UIImage?>) -> some View {
        CustomImagePicker(options: options, show: show, croppedImage: croppedImage) {
            self
        }
    }
    
    @ViewBuilder
    func frame(_ size:CGSize) -> some View {
        self.frame(width: size.width, height: size.height)
    }
}

struct CustomImagePicker<Content: View>: View {
    
    var content: Content
    var options: [Crop] = [.square, .circle, .banner]
    @Binding var show: Bool
    @Binding var croppedImage: UIImage?
    init(options: [Crop], show: Binding<Bool>, croppedImage: Binding<UIImage?>, @ViewBuilder content: @escaping () -> Content) {
        self.content = content()
        self._show = show
        self._croppedImage = croppedImage
        self.options = options
    }
    
    @State private var photosItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    @State private var showDialog: Bool = false
    @State private var selectedCropType: Crop = .square
    @State private var showCropView: Bool = false
    
    var body: some View {
        content
            .photosPicker(isPresented: $show, selection: $photosItem)
            .onChange(of: photosItem) { newValue in
                if let newValue {
                    Task {
                        if let imageData = try? await newValue.loadTransferable( type: Data.self), let image = UIImage(data: imageData) {
                            await MainActor.run(body: {
                                selectedImage = image
                                showDialog.toggle()
                            })
                        }
                    }
                }
            }
            .confirmationDialog("Choose an option", isPresented: $showDialog) {
                ForEach(options.indices, id: \.self) { index in
                    Button(options[index].name()) {
                        selectedCropType = options[index]
                        showCropView.toggle()
                    }
                }
            }
            .fullScreenCover(isPresented: $showCropView) {
                selectedImage = nil
            } content: {
                CropView(crop: selectedCropType, image: selectedImage) { croppedImage, status in
                    
                }
            }
    }
}

struct CropView: View {
    var crop: Crop
    var image: UIImage?
    var onCrop: (UIImage?, Bool) -> ()
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ImageView()
                .navigationTitle("Crop")
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarColorScheme(.dark, for: .navigationBar)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background {
                    Color.black
                        .ignoresSafeArea()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            
                        } label: {
                            Image(systemName: "checkmark")
                               .fontWeight(.semibold)
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .fontWeight(.semibold)
                        }
                    }
                }
        }
    }
    
    @ViewBuilder
    func ImageView() -> some View {
        let cropSize = crop.size()
        GeometryReader {
            let size = $0.size
            
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(size)
            }
        }
        .overlay(content: {
            Grids()
        })
        .frame(cropSize)
        .cornerRadius(crop == .circle ? cropSize.height / 2 : 0)
    }
    
    @ViewBuilder
    func  Grids() -> some View {
        ZStack {
            HStack {
                ForEach(1...5, id: \.self) { _ in
                    Rectangle()
                        .fill(.white.opacity(0.7))
                        .frame(width: 1)
                        .frame(maxWidth: .infinity)
                    
                }
            }
            
            VStack {
                ForEach(1...8, id: \.self) { _ in
                    Rectangle()
                        .fill(.white.opacity(0.7))
                        .frame(height: 1)
                        .frame(maxHeight: .infinity)
                    
                }
            }
        }
    }
}

struct CustomImagePicker_Previews: PreviewProvider {
    static var previews: some View {
        CropView(crop: .square, image: UIImage(named: "backDay")) { _, _ in
        }
    }
}

enum Crop: Equatable {
    case square
    case banner
    case circle
    
    func name() -> String {
        switch self {
        case .square:
            return "Profile"
        case .banner:
            return "Banner"
        case .circle:
            return "Circle"
        }
    }
    
    func aspectRatio() -> Double {
        switch self {
        case .square, .circle:
            return 1
        case .banner:
            return 16/9
        }
    }
    
    func size() -> CGSize {
        switch self {
        case .square, .circle:
            return CGSize(width: 300, height: 300)
        case .banner:
            return CGSize(width: 1200, height: 675)
        }
    }
}
