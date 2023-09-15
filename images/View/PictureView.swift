//
//  PictureView.swift
//  images
//
//  Created by Aliya on 13.09.2023.
//

import Foundation
import SwiftUI

struct PictureView: View {

//    let image: Image
//    let imageURL: URL?
//
//    init(image: Image, imageURL: URL?) {
//        self.image = image
//        self.imageURL = imageURL
//    }

    private let uiImage: UIImage?

    init(uiImage: UIImage) {
        self.uiImage = uiImage
    }

    var body: some View {

        if let uiImage = uiImage {
            ZStack {
                Image(uiImage: uiImage)
                    .resizable()
                    .opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .scaleEffect(10)
                VStack {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(20)
                }.padding()

            }

        } else {
            Image(systemName:" Stringfigure.mind.and.body")
        }
    }
}




struct PictureView_Previews: PreviewProvider {
    static var previews: some View {
//        PictureView(image: Image(systemName: "figure.mind.and.body"),
//                    imageURL: URL(string: "https://images.unsplash.com/photo-1691662754730-2415e37e1052?crop=entropy0026cs=tinysrgb0026fit=max0026fm=jpg0026ixid=M3w1MDEyNTR8MHwxfHJhbmRvbXx8fHx8fHx8fDE2OTQ2OTMzMjV80026ixlib=rb-4.0.30026q=800026w=1080"))
        PictureView(uiImage: UIImage(named: "ginger")!)
    }
}
///Users/aliya/Library/Developer/CoreSimulator/Devices/9E63F808-3B34-4D7D-90AE-366B129B2D67/data/Containers/Data/Application/3FE9A525-233E-44A6-9BDE-C77231C45BC7/Library/HTTPStorages/aliya.images/httpstorages.sqlite-shm
