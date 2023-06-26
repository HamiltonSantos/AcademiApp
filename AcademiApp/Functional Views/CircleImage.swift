//
//  CircleImage.swift
//  AcademiApp
//
//  Created by Hamilton Carlos da Silva Santos on 25/06/23.
//

import SwiftUI


struct CircleImage: View {
    var body: some View {
        Image("backDay")
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}


struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}
