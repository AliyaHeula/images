//
//  PictureView.swift
//  images
//
//  Created by Aliya on 13.09.2023.
//

import Foundation
import SwiftUI

struct PictureView: View {

    private let uiImage: UIImage

    init(uiImage: UIImage) {
        self.uiImage = uiImage
    }

    var body: some View {
        ZStack {
            Image(uiImage: uiImage)
                .resizable()
                .opacity(0.2)
                .edgesIgnoringSafeArea(.all)
                .scaleEffect(10)
            VStack {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(20)
            }.padding()

        }
    }
}

struct PictureView_Previews: PreviewProvider {
    static var previews: some View {
        PictureView(uiImage: UIImage(named: "ginger")!)
    }
}
