//
//  MainScreenViewModel.swift
//  images
//
//  Created by Aliya on 14.09.2023.
//

import Foundation
import SwiftUI

final class MainScreenViewModel: ObservableObject {
    @Published private var imageToShow = ImageToShow()
    @Published private var networkManager = NetworkManager()

    var uiImage: UIImage? {
        return imageToShow.uiImage
    }

    var authorName: String {
        return imageToShow.authorName
    }

    var alertText: String {
        return imageToShow.alertText
    }

    var isPreviousImageInactive: Bool {
        return imageToShow.isPreviousImageInactive
    }

    @MainActor
    func getPreviousPicture() async throws {
        try await imageToShow.getPreviousPicture()
    }

    @MainActor
    func getNextPicture() async throws {
        try await imageToShow.getNextPicture()
    }

    var isConnected: Bool {
        return networkManager.isConnected
    }

}
